public with sharing class EventController {

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Event> getDoctorEvents(Id contactId) {
        return EventSelector.getDoctorEvents(contactId);
    }

    @AuraEnabled
    public static Event createEvent(Datetime activity, Integer duration, Id patientId, Id whoId, String special) {
        return EventService.createNewEvent(activity, duration, patientId, whoId, special);
    }
}


