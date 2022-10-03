public with sharing class AppointmentPayoutSelector {

    public static List<AggregateResult> getTotalPayout(List<Contact> contacts) {
        return (List<AggregateResult>) [
                SELECT
                        Contact__c, SUM(Total_Payout__c) sum
                FROM Appointment_Payout__c
                WHERE Contact__c = :contacts
                AND Appointment_Date__c = THIS_MONTH
                GROUP BY Contact__c
        ];
    }

    public static List<Appointment_Payout__c> getAppointmentPayouts(List<Contact> contacts) {
        return [
                SELECT
                        Name, Appointment_Date__c, Total_Payout__c
                FROM Appointment_Payout__c
                WHERE Contact__c =: contacts
        ];
    }
}