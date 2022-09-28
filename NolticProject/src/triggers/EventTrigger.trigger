trigger EventTrigger on Event (after update) {
    CreateNewAppointmentPayout task = new CreateNewAppointmentPayout();
    task.createNewAppointmentPayout(Trigger.new);

}