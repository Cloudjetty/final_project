@IsTest
public with sharing class TotalPaymentBatchTest {

    @TestSetup
    public static void setup() {
        List<Contact> doctors = ContactDataFactory.createDoctors(50);
        insert doctors;
    }

    @IsTest
    public static void testChangeAccountNamesBatch() {

        Test.startTest();
        TotalPaymentBatch totalPaymentBatch = new TotalPaymentBatch();
        Id batchId = Database.executeBatch(totalPaymentBatch);
        Test.stopTest();

        System.assertEquals(50, [SELECT COUNT() FROM Contact]);

    }

}