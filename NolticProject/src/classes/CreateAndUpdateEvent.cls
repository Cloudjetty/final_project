public with sharing class CreateAndUpdateEvent {


    public static List<Appointment_Payout__c> createNewAppointmentPayout(List<Event> events) {

        Map <Id, Contact> doctors = new Map <Id, Contact>(ContactSelector.getDoctors(EventService.getEventsWhoIds(events)));

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

    public static void updateEventFieldSpecialization(List<Event> events) {

        Map <Id, Contact> doctors = new Map <Id, Contact>(ContactSelector.getDoctors(EventService.getEventsWhoIds(events)));

        for (Event event : events) {
            event.Specialization__c = doctors.get(event.WhoId).Specialization__c;
        }
    }
}

