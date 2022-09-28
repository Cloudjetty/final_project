public with sharing class EventController {

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Event> getDoctorEvents(Id contactId) {
        List<Event> eventsList = [
                SELECT Id, Subject, StartDateTime, EndDateTime
                FROM Event
                WHERE WhoId =: contactId
                AND StartDateTime = TODAY
                WITH SECURITY_ENFORCED
        ];
        return eventsList;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static Event getEventPicklist() {
        Event event = [
                SELECT Id, Specialization__c
                FROM Event
                WITH SECURITY_ENFORCED
        ];
        return event;
    }

    @AuraEnabled
    public static Event createEvent(Event ev, Id whoId) {
        ev.WhoId = whoId;
//        ev.ActivityDateTime = System.now();  // не створює івент з інпут філдів
//        ev.DurationInMinutes = 60;
        ev.OwnerId = UserInfo.getUserId();
        insert ev;
        return ev;
    }

}