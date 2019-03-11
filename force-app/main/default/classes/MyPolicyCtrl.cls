////////////////////////
//
//Project 2 - JessiCorp
//MyPolicyCtrl
//Controller for the MyPolicy Page 
//
////////////////////////


public with sharing class MyPolicyCtrl {
    public Contact userContact {get; set;}
    public id userId {get; set;}
    public User u {get; set;}

    public MyPolicyCtrl() {
        //Get the ID of the current User
        userId = UserInfo.getUserId();

        //Get the User record for that ID
        u = [SELECT id, contactid 
                  FROM User 
                  WHERE id = :userId];

        //Get the associated Contact for the Customer User and query for all
        //      fields that will be displayed
        userContact = [SELECT id,accountid, tier__c, premium_total__c, deductible__c, coverage_cap__c,
                              spouse__c, dependents__c, name, birthdate, phone, email, languagevf__c, account.name
                       FROM Contact 
                       WHERE id = :u.contactid];

    }
}