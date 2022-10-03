@IsTest
public with sharing class ContactControllerTest {

    @IsTest
    public static void insertPatient() {

        Contact patient = new Contact(
                LastName = 'Test'
        );

        Test.startTest();
            ContactController.insertPatient(patient);
        Test.stopTest();

        Contact contact = [SELECT LastName FROM Contact WHERE LastName = 'Test'];

        System.assertEquals('Test', contact.LastName);
    }

    @IsTest
    public static void getAllPatients() {

        List<Contact> contacts = new List<Contact>();

        Test.startTest();
            ContactController.getAllPatients();
        Test.stopTest();

//        Contact contact = [SELECT LastName FROM Contact WHERE LastName = 'Test'];
//
//        System.assertEquals('Test', contact.LastName);
    }

    @IsTest
    public static void getAllDoctors() {

        List<Contact> contacts = new List<Contact>();

        Test.startTest();
        ContactController.getAllDoctors();
        Test.stopTest();

//        Contact contact = [SELECT LastName FROM Contact WHERE LastName = 'Test'];
//
//        System.assertEquals('Test', contact.LastName);
    }

    @IsTest
    public static void getDoctors() {

        String specialization = 'Immunology';

        Test.startTest();
        ContactController.getDoctors(specialization);
        Test.stopTest();

//        Contact contact = [SELECT LastName FROM Contact WHERE LastName = 'Test'];
//
//        System.assertEquals('Test', contact.LastName);
    }

    @IsTest
    public static void searchDoctors() {

        String searchTerm = 'Immunology';

        Test.startTest();
        ContactController.searchDoctors(searchTerm);
        Test.stopTest();

//        Contact contact = [SELECT LastName FROM Contact WHERE LastName = 'Test'];
//
//        System.assertEquals('Test', contact.LastName);
    }
}