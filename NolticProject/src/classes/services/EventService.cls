public with sharing class EventService {

    public static List<Event> getDoctorEvents(Set<Id> contactIds) {

        Map<Id, Contact> doctors = new Map<Id, Contact>(ContactSelector.getEventsDoctors(contactIds));

        return EventSelector.getEvents(doctors.keySet());

    }

    public static Event createNewEvent(Datetime activity, Integer duration, Id patientId, Id whoId, String special) {

        Event doctorsEvent =  new Event(
                StartDateTime = activity,
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

    public static Set<Id> getEventsWhoIds(List<Event> events) {

        Set<Id> whoIds = new Set<Id>();

        for (Event event : events) {
            whoIds.add(event.WhoId);
        }
        return whoIds;
    }
}