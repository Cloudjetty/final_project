public with sharing class CreateNewAppointmentPayout {

    public void createNewAppointmentPayout(List<Event> events) {

        Set<Id> whoIds = new Set<Id>();
        for (Event event : events) {
            whoIds.add(event.WhoId);
        }

        List<Contact> doctors = new List<Contact> ([
                SELECT Name
                FROM Contact
                WHERE Id IN :whoIds
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

