public with sharing class ContactController {

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getAllParticipants() {
        List<Contact> contactsList = [
                SELECT Id, Name
                FROM Contact
                WHERE RecordType.Name = 'Patient'
                WITH SECURITY_ENFORCED
        ];
        return contactsList;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getAllDoctors() {
        List<Contact> contactsList = [
                SELECT Id, Name, Email, Total_Payment__c
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
                WITH SECURITY_ENFORCED
        ];
        return contactsList;
    }


    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getDoctors() {
        return [
                SELECT Id, Name, Specialization__c, Hourly_Rate__c
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
                WITH SECURITY_ENFORCED
        ];

    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> searchDoctors(String searchTerm) {
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getDoctors();
        }
        searchTerm = '%' + searchTerm + '%';
        return [
                SELECT Id, Specialization__c, Name, Hourly_Rate__c
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
                AND Specialization__c LIKE :searchTerm
                WITH SECURITY_ENFORCED
                ORDER BY Specialization__c
                LIMIT 12
        ];
    }
}



