////////////////////////
//
//Project 2 - JessiCorp
//Appointment Controller Test
// Test Class for the Appointment Controller
//
////////////////////////


@isTest
public class AppointmentControllerTest {
    @isTest
    public static void testAppointmentController(){
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
            AppointmentController controller = new AppointmentController();

            //Check that controller was successfully initiated
            System.assertNotEquals(controller,null);

            //Execute setPageSize method and check that the perPage variable was changed correctly
            controller.setPageSize('5');
            System.assertEquals(controller.perPage,5);

            //Execute queryDisplay and check that the appointment list is null since there are no
            //      appointments for the current user in this test
            controller.queryDisplay();
            System.assertEquals(controller.aptList,null);

            //Execute renderList and check that the isRendered variable is now true
            controller.renderList();
            System.assertEquals(controller.isRendered,true);
        }
    }
}