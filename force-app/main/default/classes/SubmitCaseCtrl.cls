////////////////////////
//
//Project 2 - JessiCorp
//SubmitCaseController
//Controller for the SubmitCase Page
//
////////////////////////


public with sharing class SubmitCaseCtrl {
    public Case newCase {get;set;}
    public Contact userContact {get;set;}

    public SubmitCaseCtrl() {
        //Get current users id
        id uID = UserInfo.getUserId();

        //Get the user record for that id
        User u = [SELECT id, contactid FROM User WHERE id = :uID];

        //get the contact record attached to that user
        userContact = [SELECT id, name, phone, email FROM Contact WHERE id = :u.contactid];

        //get the id for the Support Queue
        List<Group> q = [SELECT id FROM Group WHERE name='Support Queue' AND Type='Queue' LIMIT 1];

        //initiate the new case and assign it to the Support Queue
        newCase = new Case(contactid = userContact.id, ownerid = q.get(0).id);
    }

    public PageReference save(){
        //Save the new case in the database
        insert newCase;

        //Return users to the community landing page
        return Page.CommunitiesLanding;
    }
}