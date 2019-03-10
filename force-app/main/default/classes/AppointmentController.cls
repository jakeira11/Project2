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

    public AppointmentController() {
        oset = 0;
        perpage = 2;
        size = [SELECT count() FROM Appointment__c];
        patientId = userinfo.getUserId();
  	    isRendered = false;
        u = [Select id, contactID 
                  From user 
                  Where id=:patientId];
        queryDisplay();
        
        apt = [SELECT id,name, patient__c, patient__r.Name, doctor2__r.Name, Appointment_Time__c
                		   FROM Appointment__c
                 		   WHERE patient__r.name like 'mart%'
                           ORDER BY Appointment_Time__c
                           DESC
                           LIMIT 1];
    }

    public void save(){
        update aptList;
    }

    public void next(){
        if (oset >= size - perpage)
            oset = 0;
        else
            oset += perpage;
        queryDisplay();
    }

    public void previous(){
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

    public void setPageSize(String s){
        perpage = integer.valueof(s);
    }

    public void queryDisplay(){
        if (UserInfo.getUserType() == 'powerpartner'){
       			aptList = [SELECT id,name, patient__c, patient__r.Name, doctor2__r.Name, Appointment_Time__c
                		   FROM Appointment__c
                 		   WHERE doctor2__c = :u.id
                           ORDER BY Appointment_Time__c
                           DESC
                           LIMIT :perpage
                           OFFSET :oset];
        } else {
        		aptList = [SELECT id,name, patient__c, patient__r.Name, doctor2__r.Name, Appointment_Time__c
                   		   FROM Appointment__c
                   		   WHERE patient__c = :u.ContactId
                           ORDER BY Appointment_Time__c
                           DESC
                           LIMIT :perpage
                           OFFSET :oset];
        }
    }
    
    public void renderList(){
        isRendered = true;
    }
}