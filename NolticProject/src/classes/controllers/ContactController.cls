public with sharing class ContactController {

    @AuraEnabled
    public static void insertPatient(Contact patient) {
        insert patient;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getAllPatients() {
        List<Contact> contactsList = [
                SELECT Id, Name, RecordTypeId
                FROM Contact
                WHERE RecordType.Name = 'Patient'
                WITH SECURITY_ENFORCED
        ];
        return contactsList;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getDoctors(String specialization) {
        List<Contact> contactsList = [
                SELECT Id, Name
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
                AND Specialization__c =: specialization
                //   AND Email != NULL
                WITH SECURITY_ENFORCED
        ];
        return contactsList;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getAllDoctors() {
        List<Contact> contactsList = [
                SELECT Id, Name, Email, Total_Payment__c, Specialization__c, Hourly_Rate__c, Business_Hours__r.Name
                FROM Contact
                WHERE RecordType.Name = 'Doctor'
             //   AND Email != NULL
                WITH SECURITY_ENFORCED
        ];
        return contactsList;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> searchDoctors(String searchTerm) {
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllDoctors();
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



