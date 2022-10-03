public with sharing class EventService {

    public static List<Event> getDoctorEvents() {

        Map<Id, Contact> doctors = new Map<Id, Contact>(ContactSelector.getEventsDoctors());

        return EventSelector.getEvents(doctors.keySet());

    }

    public static Event createNewEvent(Datetime activity, Integer duration, Id patientId, Id whoId, String special) {

        Event doctorsEvent =  new Event(
                ActivityDateTime = activity,
                Specialization__c = special,
                DurationInMinutes = duration,
                WhoId = whoId,
                PatientWhoId__c = patientId,
                Subject = 'Meeting',
                OwnerId = UserInfo.getUserId()
        );
        insert doctorsEvent;
        return doctorsEvent;
    }
}