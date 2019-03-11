////////////////////////
//
//Project 2 - JessiCorp
//AccountAndOpportunityFactory
//Data factory for Test Class for Contact Trigger
//
////////////////////////



@isTest
public class AccountAndOpportunityFactory {
    public static void makeRecords(){
        
        //Create account to tie everything to and insert it
        Account a = new Account(Name = 'Test');
        insert a;
        
        ///////////////////////////////////////////////
        //Create Bronze Silver and Gold Products, 
        //      Assign Product Codes, and insert
        Product2 bronze = new Product2(Name='Bronze',ProductCode='1');
        insert bronze;
        Product2 silver = new Product2(Name='Bronze',ProductCode='2');
        insert silver;
        Product2 gold = new Product2(Name='Bronze',ProductCode='3');
        insert gold;
        ////////////////////////////////////////////////
        
        
        //Get standard pricebook id
        id p = Test.getStandardPricebookId();
        
        
        //////////////////////////////////////////////////
        //Create Bronze Silver and Gold Pricebook Entries, 
        //      attach to the Standard Pricebook and insert
        PricebookEntry sPriceBronze = new PricebookEntry(Pricebook2Id = p,
                                                   Product2Id = bronze.id,
                                                   UnitPrice=500,
                                                   IsActive=true);
        insert sPriceBronze;
        PricebookEntry sPriceSilver = new PricebookEntry(Pricebook2Id = p,
                                                   Product2Id = silver.id,
                                                   UnitPrice=1000,
                                                   IsActive=true);
        insert sPriceSilver;
        PricebookEntry sPriceGold = new PricebookEntry(Pricebook2Id = p,
                                                   Product2Id = gold.id,
                                                   UnitPrice=1500,
                                                   IsActive=true);
        insert sPriceGold;
        //////////////////////////////////////////////////////////////////////
        
        
        //////////////////////////////////////////////////////
        //Create Opportunity, Assign it the Standard Pricebook 
        //      and the Account from above and insert
        Opportunity o = new Opportunity(Name = 'TestOpp',
                                        Accountid = a.id,
                                        Pricebook2id = p,
                                        StageName='Prospecting',
                                        CloseDate=Date.today().addDays(10));
        insert o;
        //////////////////////////////////////////////////////
        
        
        //////////////////////////////////////////////////////
        //Create Bronze Silver and Gold Opportunity Products (Line Items),
        //      assign them to the opportunity, and insert
        OpportunityLineItem olBronze = new OpportunityLineItem(Quantity=1,
                                                         OpportunityId = o.id,
                                                         TotalPrice=500,
                                                         PricebookEntryId = spricebronze.id);
        insert olBronze;
        OpportunityLineItem olSilver = new OpportunityLineItem(Quantity=1,
                                                         OpportunityId = o.id,
                                                         TotalPrice=1000,
                                                         PricebookEntryId = spricesilver.id);
        insert olSilver;
        OpportunityLineItem olGold = new OpportunityLineItem(Quantity=1,
                                                         OpportunityId = o.id,
                                                         TotalPrice=1500,
                                                         PricebookEntryId = spricegold.id);
        insert olGold;
        ///////////////////////////////////////////////////////////////////
        
        
    }
}