////////////////////////
//
//Project 2 - JessiCorp
//MyPolicy Controller Test
//Test Class for the MyPolicy Page Controller
//
////////////////////////


@isTest
public class MyPolicyCtrlTest {
    @isTest
    public static void doTest(){
        //Get the page reference and set current page for test
        PageReference pageRef = Page.MyPolicy;
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

        //Run as the created user
        System.runAs(u){
            //Initiate the controller
            MyPolicyCtrl controller = new MyPolicyCtrl();

            //Check that the controller was successfully created
            System.assertNotEquals(controller,null);
        }

    }
}