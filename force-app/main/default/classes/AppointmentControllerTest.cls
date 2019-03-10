@isTest
public class AppointmentControllerTest {
    public static testMethod void testAppointmentController(){
        PageReference pageRef = Page.MyAppointment;
        Test.setCurrentPage(pageRef);
        AppointmentController appointment = new AppointmentController();
    }
}