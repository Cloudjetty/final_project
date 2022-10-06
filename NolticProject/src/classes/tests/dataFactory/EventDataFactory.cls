@IsTest
public with sharing class EventDataFactory {

    public static Event createEvent(Id contactId) {

        return new Event(
                Subject = 'Meeting',
                WhoId = contactId,
                StartDateTime = Datetime.valueOf('2022-10-12 9:00:00'),
                ActivityDateTime = Datetime.valueOf('2022-10-12 9:00:00'),
                DurationInMinutes = 30,
                Status__c = 'Pending'
        );
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