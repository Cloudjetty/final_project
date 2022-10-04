@IsTest
public with sharing class EventTest {

    @IsTest
    public static void createNewEvent() {

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        Contact patient = ContactDataFactory.createPatient();
        insert patient;

        Datetime activity = System.now() + 1;
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

    @IsTest
    public static void getDoctorEvents() {

        Contact doctor = ContactDataFactory.createDoctor();
        insert doctor;

        Test.startTest();
            Event newEvent = EventDataFactory.createEvent(doctor.Id);
            insert newEvent;

            List<Event> getDoctorEvents = EventController.getDoctorEvents(doctor.Id);

            System.assertEquals(getDoctorEvents.size(), 1);

        Test.stopTest();

    }

}