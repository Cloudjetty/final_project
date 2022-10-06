public with sharing class TotalPaymentSchedulable implements Schedulable {

    public static String expression =  '0 0 0 L * ?'; // last day of month

    public void execute(SchedulableContext sc) {
        Database.executeBatch(new TotalPaymentBatch());
    }
}

//System.schedule('Send Email', TotalPaymentSchedulable.expression,new TotalPaymentSchedulable());