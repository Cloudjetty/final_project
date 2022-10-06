public with sharing class TotalPaymentBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Contact WHERE RecordType.Name = \'Doctor\'');
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {

        List<AggregateResult> totalPayout = AppointmentPayoutSelector.getTotalPayout(scope);

        List<Contact> contacts = new List<Contact>();

        for (AggregateResult ar : totalPayout) {
                contacts.add(
                        new Contact(
                                Id = (Id) ar.get('Contact__c'),
                                Total_Payment__c = (Decimal) ar.get('sum')
                        )
                );
        }
        update contacts;
    }

    public void finish(Database.BatchableContext bc) {

        AsyncApexJob asyncApexJob = [
                SELECT Id, Status, NumberOfErrors, TotalJobItems
                FROM AsyncApexJob
                WHERE Id = :bc.getJobId()
        ];

        SendEmail.generateDoctorsPDF();
        SendEmail.sendOwnerEmailAfterBatch(asyncApexJob);
    }
}

//Id batchId = Database.executeBatch(new TotalPaymentBatch());