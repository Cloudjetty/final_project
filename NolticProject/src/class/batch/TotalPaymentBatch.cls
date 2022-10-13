public with sharing class TotalPaymentBatch implements Database.Batchable<SObject>, Database.Stateful {

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Contact WHERE RecordType.Name = \'Doctor\'');
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {

        List<AggregateResult> total = (List<AggregateResult>) [
                SELECT Contact__c, SUM(Total_Payout__c) sum
                FROM Appointment_Payout__c
                WHERE Contact__c = :scope
                AND Appointment_Date__c = THIS_MONTH
                GROUP BY Contact__c
        ];

        List<Contact> contacts = new List<Contact>();

            for (AggregateResult ar : total) {
                contacts.add(new Contact(Id = (Id)ar.get('Contact__c'),
                        Total_Payment__c = (Decimal) ar.get('sum')));
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