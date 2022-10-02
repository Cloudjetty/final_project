public with sharing class EventController {

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Event> getDoctorEvents(Id contactId) {
        List<Event> eventsList = [
                SELECT Id, Subject, StartDateTime, EndDateTime
                FROM Event
                WHERE WhoId = :contactId
                AND StartDateTime >= TODAY
                AND Status__c = 'Pending'
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
    public static Event createEvent(Datetime activity, Integer duration, Id patientId, Id whoId, String special) {
        Event ev = new Event(
                ActivityDateTime = activity,
                Specialization__c = special,
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


