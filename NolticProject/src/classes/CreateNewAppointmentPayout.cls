public with sharing class CreateNewAppointmentPayout {

    public void createNewAppointmentPayout(List<Event> events) {

        Set<Id> eventIds = new Set<Id>();
        for (Event event : events) {
            eventIds.add(event.Id);
        }

        List<EventWhoRelation> whoRelations = [
                SELECT Id, RelationId
                FROM EventWhoRelation
                WHERE EventId =: eventIds];


        Set<Id> ids = new Set<Id>();
        for (EventWhoRelation e : whoRelations) {
            ids.add(e.RelationId);
        }

        List<Contact> doctors = new List<Contact> ([
                SELECT Name
                FROM Contact
                WHERE Id IN :ids
                AND RecordType.Name = 'Doctor'
        ]);

        List<Appointment_Payout__c> newApp = new List<Appointment_Payout__c>();

        for (Event event : events) {
            for (Contact doctor : doctors) {
                if (!doctors.isEmpty() && event.Status__c == 'Completed') {
                    newApp.add(new Appointment_Payout__c(
                            Contact__c = doctor.Id,
                            Appointment_Date__c = event.ActivityDateTime,
                            Duration__c = event.DurationInMinutes
                    ));
                }
            }
        }
        insert newApp;
    }
}

