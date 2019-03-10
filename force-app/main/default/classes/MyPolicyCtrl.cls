public with sharing class MyPolicyCtrl {
    public Contact userContact {get; set;}
    public id userId {get; set;}
    public User u {get; set;}

    public MyPolicyCtrl() {
        userId = UserInfo.getUserId();

        u = [SELECT id, contactid 
                  FROM User 
                  WHERE id = :userId];

        userContact = [SELECT id,accountid, tier__c, premium_total__c, deductible__c, coverage_cap__c,
                              spouse__c, dependents__c
                       FROM Contact 
                       WHERE id = :u.contactid];

    }
}