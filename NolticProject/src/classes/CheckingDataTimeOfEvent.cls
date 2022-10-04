public with sharing class CheckingDataTimeOfEvent {

    public static void checkingDataTimeOfEvent(List<Event> events) {

        List<Event> oldEvents = EventService.getDoctorEvents();

        for (Event event : events) {
            for (Event oldEvent : oldEvents) {
                if (
                        (event.StartDateTime >= oldEvent.StartDateTime && event.StartDateTime <= oldEvent.EndDateTime) ||
                                (event.EndDateTime >= oldEvent.StartDateTime && event.EndDateTime <= oldEvent.EndDateTime) ||
                                (event.StartDateTime <= oldEvent.StartDateTime && event.EndDateTime >= oldEvent.EndDateTime)
                ) {
                    event.StartDateTime.addError('This time is busy. Please choose another time.');
                }
            }
        }
    }


    public static void checkingBusinessHoursOfEvent(List<Event> events) {

        BusinessHours hours = [
                SELECT Id
                FROM BusinessHours
                WHERE IsDefault = TRUE
                LIMIT 1
        ];

        for (Event event : events) {

            Boolean isWithin = BusinessHours.isWithin(hours.Id, event.StartDateTime);

            if (!isWithin) {
                event.StartDateTime.addError('The doctor does not work at the appointed time.');
            }
        }
    }
}

