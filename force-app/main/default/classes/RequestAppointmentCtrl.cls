////////////////////////
//
//Project 2 - JessiCorp
//RequesetAppointmentController
//Controller for the Request Appointment Page 
//
////////////////////////


public with sharing class RequestAppointmentCtrl {
    public Contact userContact {get; set;}
    public Appointment__c apt {get;set;}
    public id userId {get; set;}
    public User u {get; set;}

    public RequestAppointmentCtrl() {
        //Initialize appointment sObject
        apt = new Appointment__c();

        

        //Get the ID of the current User
        userId = UserInfo.getUserId();

        //Get the User record for that ID
        u = [SELECT id, contactid 
                  FROM User 
                  WHERE id = :userId];

        //Get the associated Contact for the Customer User and query for all
        //      fields that will be displayed
        userContact = [SELECT id,accountid 
                       FROM Contact 
                       WHERE id = :u.contactid];

    }

    public PageReference save(){
        apt.Patient__c = userContact.id;
        insert apt;
        return Page.MyAppointment;
    }
    
}