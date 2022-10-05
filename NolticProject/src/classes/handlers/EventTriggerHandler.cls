public with sharing class EventTriggerHandler {
    public static void handler(List<Event> events, List<Event> oldEvents, System.TriggerOperation triggerOperation) {
        switch on triggerOperation {
            when BEFORE_INSERT {
                CreateAndUpdateEvent.updateEventFieldSpecialization(events);
                CheckingDataTimeOfEvent.checkingDataTimeOfEvent(events);
                CheckingDataTimeOfEvent.checkingBusinessHoursOfEvent(events);
            }
            when BEFORE_UPDATE {
                CreateAndUpdateEvent.updateEventFieldSpecialization(events);
                CreateAndUpdateEvent.updateEventWhatIdField(events);
            }
            when AFTER_INSERT {
                CreateAndUpdateEvent.createNewAppointmentPayout(events);
            }
            when AFTER_UPDATE {
                CreateAndUpdateEvent.createNewAppointmentPayout(oldEvents);
            }
        }
    }
}