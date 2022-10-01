trigger EventTrigger on Event (before insert , before update , after insert , after update) {
    if (Trigger.isAfter) {
        CreateNewAppointmentPayout.createNewAppointmentPayout(Trigger.new);
    } else if (Trigger.isBefore) {
        CreateNewAppointmentPayout.updateEventWhatIdField(Trigger.new);
    }
}