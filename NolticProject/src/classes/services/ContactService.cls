public with sharing class ContactService {

    public static List<Contact> getDoctors(String specialization) {
        if (specialization == '') {
            return ContactSelector.getAllDoctors();
        }
        return ContactSelector.getDoctors(specialization);
    }

    public static List<Contact> searchDoctors(String searchTerm) {
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return ContactSelector.getAllDoctors();
        }
        searchTerm = '%' + searchTerm + '%';
        return ContactSelector.searchDoctors(searchTerm);
    }

}