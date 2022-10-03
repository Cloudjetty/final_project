@IsTest
public with sharing class ContactSelectorTest {

    @IsTest
    public static void getDoctors() {

        Set<Id> contactIds = new Set<Id>();

        Test.startTest();
        ContactSelector.getDoctors(contactIds);
        Test.stopTest();

    }

    @IsTest
    public static void getEventsDoctors() {

        Test.startTest();
        ContactSelector.getEventsDoctors();
        Test.stopTest();
    }

}