@IsTest
public with sharing class TotalPaymentSchedulableTest {

    @IsTest
    public static void totalPaymentSchedulableTest() {

        Test.startTest();

        TotalPaymentBatch totalPaymentBatch = new TotalPaymentBatch();

        String jobId = System.schedule(
                'Send Email',
                TotalPaymentSchedulable.expression,
                new TotalPaymentSchedulable()
        );

        CronTrigger ct = [
                SELECT Id, CronExpression, NextFireTime
                FROM CronTrigger
                WHERE Id = :jobId
        ];
        System.assertEquals(0, [SELECT count() FROM Case]);
        Test.stopTest();

        System.assertEquals(TotalPaymentSchedulable.expression, ct.CronExpression);
        System.assertEquals('2022-10-31 00:00:00', String.valueOf(ct.NextFireTime));

    }
}