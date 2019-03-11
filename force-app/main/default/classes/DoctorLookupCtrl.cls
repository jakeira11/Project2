////////////////////////
//
//Project 2 - JessiCorp
//DoctorLookup Controller
//Controller for the DoctorLookup page
//
////////////////////////


global with sharing class DoctorLookupCtrl {
    ApexPages.StandardController stdController;
    global List<SelectOption> radius {get;set;}
    global String radiusSelection {get;set;}
    global List<SelectOption> gender {get;set;}
    global String genderSelection {get;set;}
    global List<SelectOption> language {get;set;}
    global String languageSelection {get;set;}
    global List<SelectOption> specialization {get;set;}
    global String specialSelect {get;set;}
    global List<SelectOption> age {get;set;}
    global String ageSelection {get;set;}
    global Boolean inNetwork {get;set;}
    global String defaultaddr{get;set;}
    global Boolean isRendered {get;set;}
    global Boolean docRendered {get;set;}
    global String docFirstName {get;set;}
    global String docLastName {get;set;}
    global String practiceName {get;set;}

    List<Contact> foundDocs = new List<Contact>();
    Contact selectedDoc {get;set;}

    //global String results {get;set;}

   
                        
    

    public DoctorLookupCtrl() {
        //ID id = ApexPages.currentPage().getParameters().get('id');
        string user = userinfo.getName();
        ID userID = userinfo.getUserID();

        Contact c = [SELECT id, name FROM Contact WHERE name = :user];
        User u = [SELECT ContactId, Contact.Name, Contact.AccountId, Contact.Account.Name,
                            Street, City, PostalCode
                    FROM User WHERE ID = :userID];


        defaultaddr = u.Street + ' ' + u.City + ' ' + u.PostalCode;

        isRendered = false;
        docRendered = false;
        
    }



    public List<Contact> getFoundDocs(){
        return foundDocs;
    }

    // Query doctors that match the search criteria  
    public PageReference search() {
        
        
        List<Integer> ageRange = new List<Integer>();

        // Clear the list in case multiple searches are performed
        ageRange.clear();

        // Create a range of ages based on the user's selection 
        if (ageSelection == 'Under 35'){
            for(Integer i = 25; i < 35; i++ )
            {
                ageRange.add(i);
            }
        }
        else if (ageSelection == '35 - 45'){
            for(Integer i = 35; i < 46; i++){
                ageRange.add(i);
            }
        }
        else if (ageSelection == '46 - 55'){
            for(Integer i = 46; i < 56; i++){
                ageRange.add(i);
            }
        }
        else if (ageSelection == '56 - 65'){
            for(Integer i = 56; i < 66 ; i++){
                ageRange.add(i);
            }
        }
        else if (ageSelection == 'Any'){
            for(Integer i = 0; i < 100; i++){
                ageRange.add(i);
            }
        }
        else{
            for(Integer i = 66; i < 100 ; i++){
                ageRange.add(i);
            }
        }


        // Query for doctors that meet the user's search criteria 
        foundDocs = [
            SELECT ID, AccountID, FirstName, LastName, Gender__c, In_Network__c, LanguageVF__c,
            Account.Name, Account.BillingStreet, Account.BillingCity, Account.BillingState
            FROM Contact
            WHERE Gender__c = :genderSelection
            AND Specialization__c INCLUDES (:specialSelect)
            AND Age__c IN :ageRange
            AND LanguageVF__c = :languageSelection
            AND In_Network__c = :inNetwork
            
        ];

        if (foundDocs.size() > 0){ 
            isRendered = true; 
        }
        else { 
            isRendered = false; 
            docRendered = false;
        }

        return null;
                                                          
    }

    public Contact getSelectedDoc(){

        return selectedDoc;

    }

    public PageReference getDocInfo(){
        docRendered = true;
        System.debug('docfirstname: ' + docFirstName);
        // Need to filter by :practiceName to account for doctors with the same name
        selectedDoc = [
            SELECT ID, FirstName, LastName, LanguageVF__c, Specialization__c,
            Account.Name, Account.BillingStreet, 
            Account.BillingCity, Account.BillingState, Account.BillingPostalCode
            FROM Contact
            WHERE FirstName = :docFirstName
            AND LastName = :docLastName
        ];

        return null;
    }

    public List<SelectOption> getRadiusItems(){
        //Schema.DescribeFieldResult fieldResult = Contact.Country__c.getDescribe();
        List<SelectOption> options = new List<SelectOption>();

        options.add(new SelectOption('Any', 'Any'));

        for (integer i = 0; i < 100; i ++){
            if(i == 2 || i == 5 || i == 10 || i == 15
             || i == 20 || i == 30 || i == 50 || i == 75)
            options.add(new SelectOption(i+'',i+''));
        }
        return options;

    }

  
    public List<SelectOption> getGenderItems(){
        //Schema.DescribeFieldResult fieldResult = Contact.Country__c.getDescribe();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Male', 'Male'));
        options.add(new SelectOption('Female', 'Female'));
        
        return options;

    }


    public List<SelectOption> getLanguageItems(){
        //Schema.DescribeFieldResult fieldResult = Contact.Country__c.getDescribe();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('English', 'English'));
        options.add(new SelectOption('Spanish', 'Spanish'));
        options.add(new SelectOption('French', 'French'));
        options.add(new SelectOption('Chinese', 'Chinese'));
        

        return options;

    }

    public List<SelectOption> getAgeItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption ('Any', 'Any'));
        options.add(new SelectOption('Under 35', 'Under 35'));
        options.add(new SelectOption('35 - 45', '35 - 45'));
        options.add(new SelectOption('46 - 55', '46 - 55'));
        options.add(new SelectOption('56 - 65', '56 - 65'));
        options.add(new SelectOption('Over 65', 'Over 65'));

        return options;
    }

    public List<SelectOption> getSpecializationItems(){
        //Schema.DescribeFieldResult fieldResult = Contact.Country__c.getDescribe();
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Allergy & Immunology', 'Allergy & Immunology'));
        options.add(new SelectOption('Anesthesiology', 'Anesthesiology'));
        options.add(new SelectOption('Colon & Rectal Surgery', 'Colon & Rectal Surgery'));
        options.add(new SelectOption('Dermatology', 'Dermatology'));
        options.add(new SelectOption('Emergency Medicine', 'Emergency Medicine'));
        options.add(new SelectOption('Family Medicine', 'Family Medicine'));
        options.add(new SelectOption('General Surgery', 'General Surgery'));
        options.add(new SelectOption('Gynecology', 'Gynecology'));
        options.add(new SelectOption('Neurological Surgery', 'Neurological Surgery'));
        options.add(new SelectOption('Internal Medicine', 'Internal Medicine'));
        options.add(new SelectOption('Neurology', 'Neurology'));
        options.add(new SelectOption('Oncology', 'Oncology'));
        options.add(new SelectOption('Ophthalmology', 'Ophthalmology'));
        options.add(new SelectOption('Orthopedic Surgery', 'Orthopedic Surgery'));
        options.add(new SelectOption('Otolaryngology', 'Otolaryngology'));
        options.add(new SelectOption('Pathology', 'Pathology'));
        options.add(new SelectOption('Pediatrics', 'Pediatrics'));
        options.add(new SelectOption('Preventative Medicine', 'Preventative Medicine'));
        options.add(new SelectOption('Psychiatry', 'Psychiatry'));
        options.add(new SelectOption('Thoracic Surgery', 'Thoracic Surgery'));
        options.add(new SelectOption('Urology', 'Urology'));

        
        return options;

    }
}