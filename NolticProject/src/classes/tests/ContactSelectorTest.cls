@IsTest
public with sharing class ContactSelectorTest {


    @IsTest
    public static void getDoctors() {

        List<Contact> doctors = ContactDataFactory.createDoctors(1);
        insert doctors;

        Set<Id> doctorsId = new Set<Id>();
        for (Contact doctor : doctors) {
            doctorsId.add(doctor.Id);

            Test.startTest();
            List<Contact> doctorsResult = ContactSelector.getDoctors(doctorsId);
            Test.stopTest();

            System.assertEquals(doctorsResult.size(), 1);

        }
    }

//    @IsTest
//    public static void getEventsDoctors() {
//
//        List<Contact> doctors = ContactDataFactory.createDoctors(50);
//        insert doctors;
//
//        Set<Id> doctorsId = new Set<Id>();
//        for (Contact doctor : doctors) {
//            doctorsId.add(doctor.Id);
//
//        Test.startTest();
//            List<Contact> doctorsWithEvents = ContactSelector.getEventsDoctors(doctorsId);
//        Test.stopTest();
//
//        System.assertEquals(doctorsWithEvents.size(), 1);
//
//        }
//    }
}