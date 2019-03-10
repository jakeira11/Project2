public with sharing class PolicyEnrollCtrl {
    public Contact userContact {get; set;}
    public id userId {get; set;}
    public User u {get; set;}
    public Account acc {get; set;}

    public PolicyEnrollCtrl() {
        userId = UserInfo.getUserId();

        u = [SELECT id, contactid 
                  FROM User 
                  WHERE id = :userId];

        userContact = [SELECT id,accountid, tier__c
                       FROM Contact 
                       WHERE id = :u.contactid];

        acc = [SELECT id, bronze_premium__c, bronze_coverage_cap__c, bronze_deductible__c,
                          silver_premium__c, silver_coverage_cap__c, silver_deductible__c,
                          gold_premium__c, gold_coverage_cap__c, gold_deductible__c
                   FROM Account
                   WHERE id = :userContact.accountid
                   LIMIT 1];

    }

    public PageReference pickBronze(){
        userContact.Tier__c = 'Bronze';
        update userContact;
        return Page.MyPolicy;
    }

    public PageReference pickSilver(){
        userContact.Tier__c = 'Silver';
        update userContact;
        return Page.MyPolicy;
    }

    public PageReference pickGold(){
        userContact.Tier__c = 'Gold';
        update userContact;
        return Page.MyPolicy;
    }
}