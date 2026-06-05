public with sharing class OpportunityTriggerHelper {
   
    public static void oppAmountValidation (List<Opportunity> updatedOpps){
        
        for(Opportunity opp: updatedOpps){
            if(opp.Amount <= 5000){
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void setPrimaryContact (List<Opportunity> updatedOpps){
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp: updatedOpps){
            if(opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }

        Map<Id, Contact> ceoByAccount = new Map<Id, Contact>();
        for (Contact con : [ SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO']){
            ceoByAccount.put(con.AccountId, con);
        }

        for (Opportunity opp: updatedOpps){
            Contact ceoContact = ceoByAccount.get(opp.AccountId);
            if( ceoContact != null){
                opp.Primary_Contact__c = ceoContact.Id;
            }
        }
    }
    public static void preventDeletionClosedOpp (List<Opportunity> deletedOpps){

        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp: deletedOpps){
            if(opp.AccountId != null){
                accountIds.add(opp.AccountId);
            }
        }
        
        Map<Id, Account> accountMap = new Map<Id, Account>(
            [SELECT Id, Industry FROM Account WHERE Id IN :accountIds]
        );

        for(Opportunity opp: deletedOpps){
            Account relatedAccount = accountMap.get(opp.AccountId);

            if(opp.StageName == 'Closed Won' && relatedAccount != null && relatedAccount.Industry == 'Banking'){
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }
}