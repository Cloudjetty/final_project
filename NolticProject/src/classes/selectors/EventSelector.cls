public with sharing class EventSelector {

    public static List<Event> getEvents(Set<Id> doctorIds) {
        return [
                SELECT
                        ActivityDateTime,
                        StartDateTime,
                        EndDateTime,
                        DurationInMinutes,
                        WhoId
                FROM Event
                WHERE WhoId = :doctorIds
        ];
    }

    public static List<Event> getDoctorEvents(Id contactId) {

        return [
                SELECT
                        Id,
                        Subject,
                        StartDateTime,
                        EndDateTime
                FROM Event
                WHERE WhoId = :contactId
                AND StartDateTime >= TODAY
                AND Status__c = 'Pending'
                ORDER BY StartDateTime

        ];
    }
}