trigger EventTrigger on Event (before insert, before update, after insert, after update) {
    if (Trigger.isAfter) {
        CreateAndUpdateEvent.createNewAppointmentPayout(Trigger.new);
    } if (Trigger.isBefore) {
        if(Trigger.isUpdate) {
            CreateAndUpdateEvent.updateEventWhatIdField(Trigger.new);
            CreateAndUpdateEvent.updateEventFieldSpecialization(Trigger.new);
        }
        if(Trigger.isInsert) {
            CreateAndUpdateEvent.updateEventFieldSpecialization(Trigger.new);
            CheckingDataTimeOfEvent.checkingDataTimeOfEvent(Trigger.new);
            CheckingDataTimeOfEvent.checkingBusinessHoursOfEvent(Trigger.new);
        }
    }
}