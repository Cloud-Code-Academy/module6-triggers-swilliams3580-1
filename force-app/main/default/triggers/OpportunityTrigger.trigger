trigger OpportunityTrigger on Opportunity (before update, before delete) {

    if (Trigger.isBefore){
        if(Trigger.isUpdate){
            OpportunityTriggerHelper.oppAmountValidation(Trigger.new);
            OpportunityTriggerHelper.setPrimaryContact(Trigger.new);
        }
        
        if(Trigger.isDelete){
            OpportunityTriggerHelper.preventDeletionClosedOpp(Trigger.old);
        }
    }
    
}