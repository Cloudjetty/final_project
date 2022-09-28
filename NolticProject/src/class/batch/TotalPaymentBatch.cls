public with sharing class TotalPaymentBatch implements Database.Batchable<SObject>, Database.Stateful, Schedulable {

    public static String expression =  '0 0 0 L * ?'; // last day of month

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new TotalPaymentBatch());
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Contact WHERE RecordType.Name = \'Doctor\'');
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {

        List<AggregateResult> total = (List<AggregateResult>) [
                SELECT Contact__c, SUM(Total_Payout__c) sum
                FROM Appointment_Payout__c
                WHERE Contact__c = :scope
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

        SendEmailDoctor.generateDoctorsPDF();

//        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
//        String[] toAddresses = new String[]{
//                UserInfo.getUserEmail()
//        };
//
//        message.setToAddresses(toAddresses);
//        message.setSubject('Apex Sharing Recalculation ' + asyncApexJob.Status);
//        message.setPlainTextBody('success');
//
//        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
//                message
//        });
    }
}

//System.schedule('Send Email', TotalPaymentBatch.expression,new TotalPaymentBatch());
//Id batchId = Database.executeBatch(new TotalPaymentBatch());