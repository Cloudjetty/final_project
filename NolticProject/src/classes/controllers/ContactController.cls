public with sharing class ContactController {

    @AuraEnabled
    public static void insertPatient(Contact patient) {
        insert patient;
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getAllPatients() {
        return ContactSelector.getAllPatients();
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getAllDoctors() {
        return ContactSelector.getAllDoctors();
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> getDoctors(String specialization) {
        return ContactService.getDoctors(specialization);
    }

    @AuraEnabled(Cacheable=true Scope='global')
    public static List<Contact> searchDoctors(String searchTerm) {
        return ContactService.searchDoctors(searchTerm);
    }
}



