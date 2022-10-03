@IsTest
public with sharing class ContactSelectorTest {

    @IsTest
    public static void getDoctors() {

        List<Contact> doctors = ContactDataFactory.createDoctors(50);
        insert doctors;

        Set<Id> doctorsId = new Set<Id>();
        for (Contact doctor : doctors) {
            doctorsId.add(doctor.Id);
        }

        Test.startTest();
          List<Contact> doctorsResult = ContactSelector.getDoctors(doctorsId);
        Test.stopTest();

        System.assertEquals(doctorsResult.size(), 50);

    }

    @IsTest
    public static void getEventsDoctors() {

        Test.startTest();
        ContactSelector.getEventsDoctors();
        Test.stopTest();
    }
}