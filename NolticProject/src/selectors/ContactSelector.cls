public with sharing class ContactSelector {

    public static Map <Id, Contact> getDoctors(Set<Id> eventsIds) {
        Map <Id, Contact> doctors = new Map<Id, Contact>([
                SELECT Id, Name, Specialization__c
                FROM Contact
                WHERE Id IN :eventsIds
                AND RecordType.Name = 'Doctor'
        ]);
        return doctors;
    }
}

