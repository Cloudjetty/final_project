public with sharing class EventController {

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Event> getDoctorEvents(Id contactId) {
        List<Event> eventsList = [
                SELECT Id, Subject, StartDateTime, EndDateTime
                FROM Event
                WHERE WhoId = :contactId
                AND StartDateTime >= TODAY
                ORDER BY StartDateTime

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
    public static Event createEvent(Datetime activity, Integer duration, Id patientId, Id whoId) {
        Event ev = new Event(
                ActivityDateTime = activity,
                DurationInMinutes = duration,
                WhoId = whoId,
                PatientWhoId__c = patientId,
                Subject = 'Meeting',
                OwnerId = UserInfo.getUserId()
        );
        insert ev;
        return ev;
    }
}


