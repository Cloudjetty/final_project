public with sharing class CreateNewAppointmentPayout {

    public void createNewAppointmentPayout(List<Event> events) {

        Set<Id> whoIds = new Set<Id>();
        for (Event event : events) {
            whoIds.add(event.WhoId);
        }

        List<Contact> doctors = new List<Contact> ([
                SELECT Name
                FROM Contact
                WHERE Id IN :whoIds
                AND RecordType.Name = 'Doctor'
        ]);

        List<Appointment_Payout__c> newApp = new List<Appointment_Payout__c>();

        for (Event event : events) {
            for (Contact doc : doctors) {
                if (!doctors.isEmpty() && event.Status__c == 'Completed') {
                    newApp.add(new Appointment_Payout__c(
                            Contact__c = doc.Id,
                            Appointment_Date__c = event.StartDateTime
                    ));

                }
                event.WhatId = newApp[0].Id;
            }
        }
        insert newApp;
    }
}




//        for (Contact doc : doctors) {
//            for (Event ev : events) {
//                if (ev.Status__c == 'Completed') {
//                    newApp.add(new Appointment_Payout__c(
//                            Contact__c = ev.WhoId,
//                            Appointment_Date__c = ev.StartDateTime
//                      //      Duration__c = (Time) (ev.EndDateTime - ev.StartDateTime)
//
//                    ));
//                }
//            }
//        }
//        insert newApp;
//    }
//}