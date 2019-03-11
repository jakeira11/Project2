////////////////////////
//
//Project 2 - JessiCorp
//RequestAppointmentController Test
//Test Class for the RequestAppointment Page Controller
//
////////////////////////


@isTest
public with sharing class RequestAppointmentCtrlTest {
    @isTest
    public static void doTest() {
        PageReference pageRef = Page.RequestAppointment;
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
            //Initiate the controller
            RequestAppointmentCtrl controller = new RequestAppointmentCtrl();

            //Check that controller was successfully initiated
            System.assertNotEquals(controller,null);

            controller.apt.Appointment_Time__c = Datetime.now();
            
            //Run the save method and check the return value
            //Should return user to the landing page
            System.assertEquals(controller.save(),Page.MyAppointment);

            //Query for the appointment we just saved
            Appointment__c result = [SELECT id,patient__c FROM Appointment__c LIMIT 1];

            //Ensure the resulting appointment is not null and has the correct information
            System.assertNotEquals(result,null);
            System.assertEquals(result.patient__c,c.id);
            
        }
    }
}