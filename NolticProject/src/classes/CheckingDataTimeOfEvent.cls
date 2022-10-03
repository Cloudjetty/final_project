public with sharing class CheckingDataTimeOfEvent {

    public static void checkingDataTimeOfEvent(List<Event> events) {

   //     List<Event> oldEvents = EventService.getDoctorEvents();

        Map<Id, Event> oldEvents = new Map<Id, Event>(EventService.getDoctorEvents());
        Map<Id, Datetime> activity = new Map<Id, Datetime>();

        for (Id id : oldEvents.keySet()) {
            activity.put(id, oldEvents.get(id).ActivityDateTime);
        }


        for (Event event : events) {
         //   for (Event oldEvent : oldEvents) {
                if (event.ActivityDateTime == oldEvents.get(Id).ActivityDateTime) {
                    event.StartDateTime.addError('Time!!!');
                }
         //   }
        }
    }
}