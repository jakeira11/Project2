////////////////////////
//
//Project 2 - JessiCorp
//Appointment Controller
//This class is a custom controller for the appointment object
//that allows the user to perform pagenation and 
//
////////////////////////



public class AppointmentController {
    public List<Appointment__c> aptList{get;set;}
    public Appointment__c apt{get;set;}
    public integer oset;
    public integer perpage {get;set;}
    public integer size;
    public id patientID {get;set;}
    public Contact userContact;
    public User u {get; set;}
    public Boolean isRendered {get;set;}
    public integer rowNum{get;set;}

    //This constructor sets all values and queries the Appointment__c custom object;
    public AppointmentController() {
        oset = 0;
        perpage = 2;
        rowNum = 1;
        size = [SELECT count() FROM Appointment__c];
        patientId = userinfo.getUserId();
  	    isRendered = false;
        u = [Select id, contactID 
                  From user 
                  Where id=:patientId];
        queryDisplay();
        
        apt = [SELECT id,name, patient__c, patient__r.Name, doctor2__r.Name, Appointment_Time__c, Appointment_Reason__c, Practice__c
                		   FROM Appointment__c
                 		   WHERE patient__r.name like 'mart%'
                           ORDER BY Appointment_Time__c
                           DESC
                           LIMIT 1];
    }
	
    //This method updates the Appointment List
    public void save(){
        update aptList;
    }

    //This method checks the current offset and updates the page accordingly.
    //If the user is on the last page and selects next it brings them back to the beginning
    public void previous(){
        if (oset >= size - perpage){
            oset = 0;
            
        }
            
        else{
            integer i=0;
            while (i < size){
                i += perpage;
            }
            rowNum += perpage;
        }
        queryDisplay();
    }

    //This method checks the current offset and updates the page accordingly.
    //If the user is on the first page and selects next it brings them back to the end
    public void next(){
        if (oset <= perpage){
            integer i = 0;
            while (i < size){
                i += perpage;
            }
            oset = i - perpage;
        }
        else
           oset -= perpage;
        queryDisplay();
    }

    //This method is currently not in use but when called will set the
    //number of appointments that are displayed per page
    public void setPageSize(String s){
        perpage = integer.valueof(s);
    }

    //This method checks to see if the user is a doctor or not and 
    //queries the database accordingly to get the necessary information
    //to display in the list
    public void queryDisplay(){
        if (UserInfo.getUserType() == 'powerpartner'){
       			aptList = [SELECT id,name, patient__c, patient__r.Name, doctor2__r.Name, Appointment_Time__c, 
                                  Appointment_Reason__c, practice__r.name
                		   FROM Appointment__c
                 		   WHERE doctor2__c = :u.id
                           ORDER BY Appointment_Time__c
                           DESC
                           LIMIT :perpage
                           OFFSET :oset];
        } else {
        		aptList = [SELECT id,name, patient__c, patient__r.Name, doctor2__r.Name, Appointment_Time__c, 
                                  Appointment_Reason__c, practice__r.name
                   		   FROM Appointment__c
                   		   WHERE patient__c = :u.ContactId
                           ORDER BY Appointment_Time__c
                           DESC
                           LIMIT :perpage
                           OFFSET :oset];
        }
    }
    
    //When called this method will change the isRendered value to true
    public void renderList(){
        isRendered = true;
        id inID = System.currentPageReference().getParameters().get('ApptID');
        for(Appointment__c appointment: aptList)
            if(appointment.id == inID)
            	apt = appointment;
    }
    
}