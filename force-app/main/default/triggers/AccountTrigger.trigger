trigger AccountTrigger on Account (before insert, after insert) {

    if(Trigger.isInsert && Trigger.isBefore){
        AccountTriggerHelper.updateAccountTypeToProspect(Trigger.new);
        AccountTriggerHelper.copyAccountShippingAddress(Trigger.new);
        AccountTriggerHelper.setAccountRating(Trigger.new);
    }

    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHelper.createRelatedContact(Trigger.new);
    }
}