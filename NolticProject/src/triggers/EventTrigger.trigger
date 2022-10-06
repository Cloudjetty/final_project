trigger EventTrigger on Event (before insert, before update, after insert, after update) {
    EventTriggerHandler.handler(
            Trigger.new,
            Trigger.old,
            Trigger.operationType
    );
}