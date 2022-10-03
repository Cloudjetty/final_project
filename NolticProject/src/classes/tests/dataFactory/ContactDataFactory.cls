@IsTest
public with sharing class ContactDataFactory {

    public static Contact createContact() {
        return new Contact(
                LastName = 'Test'
        );
    }

    public static List<Contact> createPatients(Integer amountOfContacts) {

        List<Contact> patients = new List<Contact>();

        Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Patient').getRecordTypeId();

        for (Integer i = 0; i < amountOfContacts; i++) {
            patients.add(
                    new Contact(
                            LastName = 'Test' + i,
                            RecordTypeId = recordTypeId
                    )
            );
        }
        return patients;
    }

    public static List<Contact> createDoctors(Integer amountOfContacts) {

        List<Contact> doctors = new List<Contact>();

        Id recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Doctor').getRecordTypeId();

        for (Integer i = 0; i < amountOfContacts; i++) {
            doctors.add(
                    new Contact(
                            LastName = 'Test' + i,
                            RecordTypeId = recordTypeId
                    )
            );
        }
        return doctors;
    }


    public static Contact createDoctor() {
        return new Contact(
                LastName = 'Doctor Test',
                Specialization__c = 'Immunology'
        );
    }




}