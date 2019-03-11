////////////////////////
//
//Project 2 - JessiCorp
//PolicyEnrollController
//Controller for the PolicyEnroll Page
//
////////////////////////


public with sharing class PolicyEnrollCtrl {
    public Contact userContact {get; set;}
    public id userId {get; set;}
    public User u {get; set;}
    public Account acc {get; set;}

    public PolicyEnrollCtrl() {
        //get the current user's id
        userId = UserInfo.getUserId();

        //get the user record by id
        u = [SELECT id, contactid 
                  FROM User 
                  WHERE id = :userId];

        //get the associated Contact record for the user
        userContact = [SELECT id,accountid, tier__c
                       FROM Contact 
                       WHERE id = :u.contactid];

        //get the account associated with that contact
        acc = [SELECT id, bronze_premium__c, bronze_coverage_cap__c, bronze_deductible__c,
                          silver_premium__c, silver_coverage_cap__c, silver_deductible__c,
                          gold_premium__c, gold_coverage_cap__c, gold_deductible__c
                   FROM Account
                   WHERE id = :userContact.accountid
                   LIMIT 1];

    }

    //If the user clicks this button, update their record
    //      by changing the Tier field to bronze
    public PageReference pickBronze(){
        userContact.Tier__c = 'Bronze';
        update userContact;
        return Page.MyPolicy;
    }

    //If the user clicks this button, update their record
    //      by changing the Tier field to silver
    public PageReference pickSilver(){
        userContact.Tier__c = 'Silver';
        update userContact;
        return Page.MyPolicy;
    }

    //If the user clicks this button, update their record
    //      by changing the Tier field to gold
    public PageReference pickGold(){
        userContact.Tier__c = 'Gold';
        update userContact;
        return Page.MyPolicy;
    }
}