////////////////////////
//
//Project 2 - JessiCorp
//SubmitCaseController Test
//Test Class for the SubmitCase Page Controller
//
////////////////////////


@isTest
public with sharing class SubmitCaseCtrlTest {
    @isTest
    public static void doTest() {
        PageReference pageRef = Page.SubmitCase;
        Test.setCurrentPage(pageRef);
        Test.setCurrentPageReference(pageRef);

        //Create account to tie the contact to
        Account a = new Account(Name = 'Test');
        insert a;

        //Create a contact for that account
        Contact c = new Contact(LastName = 'test' ,accountid = a.id, tier__c = 'bronze', premium__c = 500,
                                deductible__c = 500, coverage_cap__c = 500);
        insert c;

        //Create a user using the Customer contact record
        String uniqueUserName = 'customeruser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id,Name FROM Profile WHERE Name = 'Southern Heart Customer Plus'];
        User u = new User(Alias = 'test', Email='standarduser@testorg.com', contactid = c.id,
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles',
                          UserName=uniqueUserName);

        System.runAs(u){

            //initiate controller
            SubmitCaseCtrl controller = new SubmitCaseCtrl();

            //Check that controller was successfully initiated
            System.assertNotEquals(controller,null);

            //create the case in the controller
            controller.newCase = new Case(contactid = c.id,subject = 'test');
            
            //Run the save method and check the return value
            //Should return user to the landing page
            System.assertEquals(controller.save(),Page.CommunitiesLanding);

            //get the case that was saved
            Case result = [SELECT id,contactid FROM Case LIMIT 1];

            //Check that the case is not null and the contact id is correct
            System.assertNotEquals(result,null);
            System.assertEquals(result.contactid,c.id);
        }
    }
}