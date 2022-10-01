public with sharing class CreateNewAppointmentPayout {

    public static List<Appointment_Payout__c> createNewAppointmentPayout(List<Event> events) {

        Set<Id> whoIds = new Set<Id>();

        for (Event event : events) {
            whoIds.add(event.WhoId);
        }

        Map <Id, Contact> doctors = new Map<Id, Contact>([
                SELECT Name
                FROM Contact
                WHERE Id IN :whoIds
                AND RecordType.Name = 'Doctor'
        ]);

        List<Appointment_Payout__c> newApp = new List<Appointment_Payout__c>();

        for (Event event : events) {
                if (!doctors.isEmpty() && event.Status__c == 'Completed') {
                    newApp.add(new Appointment_Payout__c(
                            Contact__c = doctors.get(event.WhoId).Id,
                            Appointment_Date__c = event.ActivityDateTime,
                            Duration__c = event.DurationInMinutes
                    ));
            }
        }
        insert newApp;
        return newApp;
    }

    public static void updateEventWhatIdField(List<Event> events) {

        List<Appointment_Payout__c> newApp = createNewAppointmentPayout(events);

        for (Event event : events) {
            for (Appointment_Payout__c ap : newApp) {
                event.WhatId = ap.Id;
            }
        }
    }
}

