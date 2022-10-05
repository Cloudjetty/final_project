public with sharing class ContactSelector {

    public static List<Contact> getDoctors(Set<Id> contactIds) {
        return [
                SELECT
                        Id, Name, Specialization__c
                FROM Contact
                WHERE Id IN :contactIds
                AND RecordType.Name = 'Doctor'
        ];
    }

    public static List<Contact> getEventsDoctors(Set<Id> contactIds) {
        return [
                SELECT
                        Id, Name, Specialization__c,
                (SELECT
                        Id FROM OpenActivities WHERE IsTask = FALSE)
                FROM Contact
                WHERE Id IN :contactIds
                AND RecordType.Name = 'Doctor'
        ];
    }

    public static List<Contact> getAllPatients() {
        return [
                SELECT
                        Id, Name, RecordTypeId
                FROM Contact
                WHERE RecordType.Name = 'Patient'
        ];
    }

    public static List<Contact> getAllDoctors() {
        return [
                SELECT
                        Id, Name, Email, Total_Payment__c,
                        Specialization__c, Hourly_Rate__c, Business_Hours__r.Name
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
        ];
    }

    public static List<Contact> searchDoctors(String searchTerm) {
        return [
                SELECT
                        Id, Specialization__c, Name, Hourly_Rate__c
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
                AND Specialization__c LIKE :searchTerm
                WITH SECURITY_ENFORCED
                ORDER BY Specialization__c
                LIMIT 12
        ];
    }

    public static List<Contact> getDoctorsWithSpecialization(String specialization) {
        return [
                SELECT
                        Id, Name
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
                AND Specialization__c =: specialization

        ];
    }
}


