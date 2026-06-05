public with sharing class AccountTriggerHelper {
    
    public static void updateAccountTypeToProspect(List<Account> newAccounts){
        
        for(Account acc : newAccounts){
            if(acc.Type == null){
                acc.Type = 'Prospect';
            }
        }
    }

    public static void copyAccountShippingAddress(List<Account> newAccounts){
        
        for(Account acc: newAccounts){
            if(acc.ShippingStreet != null 
            && acc.ShippingCity != null 
            && acc.ShippingState != null 
            && acc.ShippingPostalCode != null 
            && acc.ShippingCountry != null) {
                
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
                
            }
        }
    }

    public static void setAccountRating(List<Account> newAccounts){

        for(Account acc: newAccounts){
            if(acc.Phone != null && acc.Website != null && acc.Fax != null){
                acc.Rating = 'Hot';
            }
        }
    }

    public static void createRelatedContact(List<Account> newAccounts){

        List<Contact> newCreatedContacts = new List<Contact>();

        for(Account acc: newAccounts){
            Contact newContact = new Contact(
                LastName = 'DefaultContact', 
                Email = 'default@email.com', 
                AccountId = acc.Id);
            newCreatedContacts.add(newContact);
        }
        insert newCreatedContacts;
    }
}

   