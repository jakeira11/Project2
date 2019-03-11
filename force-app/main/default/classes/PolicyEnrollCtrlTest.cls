////////////////////////
//
//Project 2 - JessiCorp
//PolicyEnrollController Test
//Test Class for the PolicyEnroll Page Controller
//
////////////////////////


@isTest
global with sharing class PolicyEnrollCtrlTest {

    @TestSetup
    static void doSetup(){
        //Create an account and insert
        Account a = new Account(Name='test',bronze_premium__c = 500, bronze_coverage_cap__c = 1000, bronze_deductible__c=1000,
                        silver_premium__c=1000, silver_coverage_cap__c=1000, silver_deductible__c=1000,
                        gold_premium__c=1500, gold_coverage_cap__c=1000, gold_deductible__c=1000);
        insert a;

        //Create a Customer Contact and insert
        Contact c = new Contact(LastName='test', accountid = a.id, tier__c = 'bronze');
        insert c;
      
    }

    @isTest
    global static void doTest() {
        //Get the page reference and set current page for test
        PageReference pageRef = Page.PolicyEnrollPage;
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);

        //get the account and contact from the testSetup
        Account a = [SELECT id FROM Account LIMIT 1];
        Contact c = [SELECT id FROM Contact LIMIT 1];

        //Create a user using the Customer contact record
        String uniqueUserName = 'customeruser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id,Name FROM Profile WHERE Name = 'Southern Heart Customer Plus'];
        User u = new User(Alias = 'test', Email='standarduser@testorg.com', contactid = c.id,
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles',
                          UserName=uniqueUserName);

        //Share Account/Contact with the user
        AccountShare accShr = new AccountShare();
        accShr.AccountId = a.id;
        accShr.UserorGroupId = u.id;
        accShr.AccountAccessLevel = 'All';
        Database.saveresult sr2 = Database.insert(accShr,false);


        //Run page as the user created
        System.runAs(u){
            //Get Controller
            PolicyEnrollCtrl controller = new PolicyEnrollCtrl();

            //Run the Methods in the controller
            PageReference bronze = controller.pickBronze();
            PageReference silver = controller.pickSilver();
            PageReference gold = controller.pickGold();
            Test.stopTest();

            //Assert the pages that were returned
            System.assertEquals(bronze,Page.MyPolicy);
            System.assertEquals(silver,Page.MyPolicy);
            System.assertEquals(gold,Page.MyPolicy);

            //Get the Customer contact and assert that the tier is now gold, since that page was run last.
            Contact result = [SELECT id, tier__c FROM Contact LIMIT 1];
            System.assertEquals('Gold',result.tier__c);
        }        
    }
}