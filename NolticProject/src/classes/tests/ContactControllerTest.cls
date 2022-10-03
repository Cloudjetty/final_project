@IsTest
public with sharing class ContactControllerTest {

    @IsTest
    public static void insertPatient() {

        Contact patient = ContactDataFactory.createContact();

        Test.startTest();
            ContactController.insertPatient(patient);
        Test.stopTest();

        Contact contact = [SELECT LastName FROM Contact WHERE LastName = 'Test'];
        System.assertEquals('Test', contact.LastName);
    }

    @IsTest
    public static void getAllPatients() {

        List<Contact> contacts = ContactDataFactory.createPatients(50);
        insert contacts;

        Test.startTest();
            ContactController.getAllPatients();
        Test.stopTest();

        List<Contact> patients = [SELECT Id FROM Contact WHERE RecordType.Name = 'Patient'];

        System.assertEquals(patients.size(), 50);
    }

    @IsTest
    public static void getAllDoctors() {

        List<Contact> contacts = ContactDataFactory.createDoctors(50);
        insert contacts;

        Test.startTest();
            ContactController.getAllDoctors();
        Test.stopTest();

        List<Contact> doctors = [SELECT Id FROM Contact WHERE RecordType.Name = 'Doctor'];

        System.assertEquals(doctors.size(), 50);
    }

    @IsTest
    public static void getDoctors() {

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        String specialization = 'Immunology';

        Test.startTest();
            List<Contact> result = ContactController.getDoctors(specialization);

            List<Contact> contacts = ContactDataFactory.createDoctors(49);
            insert contacts;

            String specialization2 = '';

            List<Contact> result2 = ContactService.getDoctors(specialization2);

        Test.stopTest();

        System.assertEquals(result.size(), 1);
        System.assertEquals(result2.size(), 50);
    }

    @IsTest
    public static void searchDoctors() {

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        String searchTerm = 'Immunology';

        Test.startTest();
            List<Contact> result = ContactController.searchDoctors(searchTerm);

            List<Contact> contacts = ContactDataFactory.createDoctors(49);
            insert contacts;

            String searchTerm2 = '';

            List<Contact> result2 = ContactService.searchDoctors(searchTerm2);
        Test.stopTest();

        System.assertEquals(result.size(), 1);
        System.assertEquals(result2.size(), 50);
    }

}