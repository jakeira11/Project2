@isTest public class FamilyTriggerTest {
	@isTest
    public static void doTest(){
        //Call data factory
        AccountAndOpportunityFactory.makeRecords();
        
        
        //Get the account
        Account acc = [SELECT id FROM Account LIMIT 1];
        
        
        //Create Bronze contact records and insert
        List<Contact> cons = new List<Contact>();
        for(integer i = 0; i < 100; i++){
            cons.add(new Contact(LastName = 'test' + i,
                                 Accountid = acc.id,
                                 Tier__c = 'Bronze'));
        }
        insert cons;
        
        
        //Create list of family records
        List<Family__c> families = new List<Family__c>();
        
        
        //populate the list with family records attached to 50
        //		different contact records
        for (Contact c : [SELECT id, tier__c FROM Contact WHERE tier__c = 'Bronze']){
            Family__c fam = new Family__c(Name = 'test',
                                          Date_of_birth__c = Date.today(),
                                          Policy_Holder__c = c.id);
            families.add(fam);
        }
        
        
        //insert family records, which thanks to the 
        //		master detail relationship, will 
        //		fire the Contact Update Trigger
        insert families;
        
        
        //Check that all of the Bronze contacts that now have families
        //		to ensure the premiums have increased accordingly
        for (Contact c : [SELECT id, tier__c, premium__c FROM Contact WHERE tier__c = 'Bronze']){
            System.debug(c.Premium__c);
        	System.assert(c.Premium__c == 600 || c.Premium__c == 650);
        }
        
        //delete the family records
        delete families;
        
        //Check that all of the bronze contacts have now gone back to
        //		the original premium of 500
        for (Contact c : [SELECT id, tier__c, premium__c FROM Contact WHERE tier__c = 'Bronze']){
            System.debug(c.premium__c);
        	System.assert(c.Premium__c == 500);
        }
    }
}