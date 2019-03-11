///////////////////////
//
//Project 2 - JessiCorp
//Tests for Contact and Family Triggers
//      and related helpers.
//
///////////////////////

@isTest
public class ContactTriggerNewPolicyTest {
    @isTest
    public static void doTest(){
        AccountAndOpportunityFactory.makeRecords();
        
        //start test
        Test.startTest();
        
        //Get the Account from the testSetup method
        Account a = [SELECT id FROM Account LIMIT 1];
        
        
        //Create list to store the Contacts in
        //      to be inserted
        List<Contact> cons = new List<Contact>();
        
        
        //Create 50 Bronze tier Contacts and add to list
        for (integer i = 0; i < 50; i++){
            Contact c = new Contact(LastName = 'Test' + i,
                                    Accountid = a.id,
                                    Tier__c = 'Bronze');
            cons.add(c);
        }
        
        
        //Create 50 Silver tier Contacts and add to list
        for (integer i = 0; i < 50; i++){
            Contact c = new Contact(LastName = 'Test' + (50 + i),
                                    Accountid = a.id,
                                    Tier__c = 'Silver');
            cons.add(c);
        }
        
        
        //Create 50 Gold tier Contacts and add to list
        for (integer i = 0; i < 50; i++){
            Contact c = new Contact(LastName = 'Test' + (100 + i),
                                    Accountid = a.id,
                                    Tier__c = 'Gold');
            cons.add(c);
        }
        
        //Insert all 150 contacts
        insert cons;
        
        //end test
        Test.stopTest();
        
        /////////////////////////
        //  ASSERTIONS
        /////////////////////////
        
        List<Contact> resultsBronze = [SELECT id,Tier__c,Premium__c FROM Contact LIMIT 50];
        List<Contact> resultsSilver = [SELECT id,Tier__c,Premium__c FROM Contact LIMIT 50 OFFSET 50];
        List<Contact> resultsGold = [SELECT id,Tier__c,Premium__c FROM Contact LIMIT 50 OFFSET 100];
        
        for (Contact c : resultsBronze){
            System.assert(c.Tier__c == 'Bronze' && c.Premium__c == 500);
        }
        for (Contact c : resultsSilver){
            System.assert(c.Tier__c == 'Silver' && c.Premium__c == 1000);
        }
        for (integer i = 0; i < resultsGold.size(); i++){
            System.assert(resultsGold.get(i).Tier__c == 'Gold' && resultsGold.get(i).Premium__c == 1500);
            resultsGold.get(i).Tier__c = 'Bronze';
        }
        
        ////////////////////////////////////
        //END ASSERTIONS FOR INSERT TRIGGER
        //Now making edits to contacts to test Update Trigger
        ////////////////////////////////////
        
        
        //After the insertion, the tier was changed to bronze
        //      Update the records to test the Update trigger
        update resultsGold;
        
        //Get all the contacts that have a premium of 500 (Bronze)
        //  and assert that the size of the list should be 100.
        //  (The 50 original and the 50 we just updated)
        List<Contact> updateResults = [SELECT id,premium__c FROM Contact WHERE premium__c = 500];
        System.assertEquals(100,updateResults.size());
        
    }
}