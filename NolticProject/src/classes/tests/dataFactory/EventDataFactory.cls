@IsTest
public with sharing class EventDataFactory {

    public static Event createEvent(Id contactId) {

        return new Event(
                Subject = 'Meeting',
                WhoId = contactId,
                ActivityDateTime = System.now() + 2,
                DurationInMinutes = 30,
                Status__c = 'Pending'
        );
    }
}