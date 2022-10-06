@IsTest
public with sharing class EventTest {

    @IsTest(SeeAllData = true)
    public static void createNewEvent() {

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        Contact patient = ContactDataFactory.createPatient();
        insert patient;

        Datetime activity = Datetime.valueOf('2022-10-12 9:00:00');
        Integer duration = 60;
        Id patientId = patient.Id;
        Id whoId = doctor.Id;
        String special = 'Immunology';


        Test.startTest();
            Event newEvent = EventController.createEvent(
                    activity, duration, patientId, whoId, special
            );
            System.assertEquals(newEvent.WhoId, doctor.Id);

            newEvent.Status__c = 'Completed';
            update newEvent;

        Test.stopTest();

    }

    @IsTest(SeeAllData = true)
    public static void getDoctorEvents() {

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        Event newEvent = EventDataFactory.createEvent(doctor.Id);
        insert newEvent;


        Test.startTest();
            List<Event> getDoctorEvents = EventController.getDoctorEvents(doctor.Id);
        Test.stopTest();

        System.assertEquals(getDoctorEvents.size(), 1);

    }

    @IsTest(SeeAllData = true)
    public static void checkingBusinessHoursOfEvent() {

        Datetime someDateTime = Datetime.valueOf('2022-10-08 9:00:00');

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        Event newEvent = EventDataFactory.createEvent(doctor.Id);
        insert newEvent;

        Exception e = null;

        Test.startTest();
            try {
                newEvent.StartDateTime = someDateTime;
                update newEvent;

            } catch (Exception ex) {
                e = ex;
            }

        Test.stopTest();

        System.assertNotEquals(null, e);

    }

}