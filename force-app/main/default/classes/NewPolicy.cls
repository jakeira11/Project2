////////////////////////
//
//Project 2 - JessiCorp
//NewPolicy Class - Contact Trigger Helper
//Provides functionality for the BeforeInsert and BeforeUpdate Contact Triggers
//for updating prices for a new Policy on a Contact.
//
////////////////////////



public class NewPolicy {

    //updatePrices Overload for BeforeUpdate
    public static void updatePrices(List<Contact> cons){

        //Create lists for Account IDs, Opportunities, and Opportunity Products(LineItems)
        List<Id> accIDs = new List<Id>();
        List<Account> accounts = new List<Account>();
        List<Opportunity> opps = new List<Opportunity>();
        List<OpportunityLineItem> oppLine = new List<OpportunityLineItem>();

        //Get a list of all accounts that the contacts are tied to
        for (Contact c : cons){
            accIds.add(c.accountid);
        }

        for (Account a : [SELECT id, Coverage_Cap__c, Deductible__c, Premium__c
                          FROM Account
                          WHERE id IN :accIds]){
            accounts.add(a);
        }

        //Using the Account IDs, query for all the associated Opportunities
        for (Opportunity o : [SELECT id,accountid FROM Opportunity WHERE accountid IN :accIds]){
            opps.add(o);
        }

        //Using the Opportunities, query for all the Opportunity Products tied to them
        for (OpportunityLineItem ol : [SELECT id,opportunityid,unitprice,productcode FROM OpportunityLineItem WHERE opportunityid IN :opps]){
            oppLine.add(ol);
        }

        //Variable used in the below for loops
        Decimal premium = 0;

        //Loop through the contacts that fired the trigger
        for (Contact c : cons){

            //If the customized flag has not been set, and the customer is Bronze tier
            //Customized flag prevents trigger from affecting the record because the user's premium, etc have been set manually
            //  because they wanted to customize their plan further.
            if (c.Customized__c == false && c.Tier__c == 'Bronze'){

                //nested for loops loop through both the opportunity and opportunity product lists to find the ones
                //that match the current contact record
                
                for (integer j = 0; j < opps.size(); j++){
                    for (integer i = 0; i < oppLine.size(); i++){
                        
                        //if the OpportunityProduct matches the Opportunity, and
                        //  the Opportunity's Account matches the Contact's Account, and
                        //  the OpportunityProduct Product Code is 1 (BRONZE),
                        //  THEN set the premium variable using that OpportunityProduct Unit Price
                        if (oppLine.get(i).opportunityid == opps.get(j).id && 
                            opps.get(j).accountid == c.AccountId && 
                            oppLine.get(i).ProductCode == '1'){

                                //Store the unit price to use for filling the customer's premium
                                premium = oppLine.get(i).UnitPrice;
                                
                        }
                    }
                }
                
                //Set contact premium, coverage cap, and deductible based on the Opportunity Product
                // UnitPrice and number of Spouses and Dependents
                c.Premium__c = premium;
                c.Coverage_Cap__c = 1500;
                c.Deductible__c = 1000;

                for (integer i = 0; i < accounts.size(); i++){
                    if (accounts.get(i).id == c.accountid){
                        accounts.get(i).Bronze_Premium__c = premium;
                        accounts.get(i).Bronze_Coverage_Cap__c = c.Coverage_Cap__c;
                        accounts.get(i).Bronze_Deductible__c = c.Deductible__c;
                    }
                }
            }

            //If the customized flag has not been set, and the customer is Silver tier
            if (c.Customized__c == false && c.Tier__c == 'Silver'){

                //nested for loops loop through both the opportunity and opportunity product lists to find the ones
                //that match the current contact record
                for (integer j = 0; j < opps.size(); j++){
                    for (integer i = 0; i < oppLine.size(); i++){
                        
                        //if the OpportunityProduct matches the Opportunity, and
                        //  the Opportunity's Account matches the Contact's Account, and
                        //  the OpportunityProduct Product Code is 2 (SILVER),
                        //  THEN set the premium variable using that OpportunityProduct Unit Price
                        if (oppLine.get(i).opportunityid == opps.get(j).id && 
                            opps.get(j).accountid == c.AccountId && 
                            oppLine.get(i).ProductCode == '2'){

                                //Store the unit price to use for filling the customer's premium
                                premium = oppLine.get(i).UnitPrice;
                                
                        }
                    }
                }
                
                //Set contact premium, coverage cap, and deductible based on the Opportunity Product
                // UnitPrice and number of Spouses and Dependents
                c.Premium__c = premium;
                c.Coverage_Cap__c = 2000;
                c.Deductible__c = 600;

                for (integer i = 0; i < accounts.size(); i++){
                    if (accounts.get(i).id == c.accountid){
                        accounts.get(i).Silver_Premium__c = premium;
                        accounts.get(i).Silver_Coverage_Cap__c = c.Coverage_Cap__c;
                        accounts.get(i).Silver_Deductible__c = c.Deductible__c;
                    }
                }
            }

            //If the customized flag has not been set, and the customer is Gold tier
            if (c.Customized__c == false && c.Tier__c == 'Gold'){

                //nested for loops loop through both the opportunity and opportunity product lists to find the ones
                //that match the current contact record
                for (integer j = 0; j < opps.size(); j++){
                    for (integer i = 0; i < oppLine.size(); i++){
                        
                        //if the OpportunityProduct matches the Opportunity, and
                        //  the Opportunity's Account matches the Contact's Account, and
                        //  the OpportunityProduct Product Code is 3 (GOLD),
                        //  THEN set the premium variable using that OpportunityProduct Unit Price
                        if (oppLine.get(i).opportunityid == opps.get(j).id && 
                            opps.get(j).accountid == c.AccountId && 
                            oppLine.get(i).ProductCode == '3'){

                                //Store the unit price to use for filling the customer's premium
                                premium = oppLine.get(i).UnitPrice;
                                
                        }
                    }
                }
                
                //Set contact premium, coverage cap, and deductible based on the Opportunity Product
                // UnitPrice and number of Spouses and Dependents
                c.Premium__c = premium;
                c.Coverage_Cap__c = 2250;
                c.Deductible__c = 300;

                for (integer i = 0; i < accounts.size(); i++){
                    if (accounts.get(i).id == c.accountid){
                        accounts.get(i).Gold_Premium__c = premium;
                        accounts.get(i).Gold_Coverage_Cap__c = c.Coverage_Cap__c;
                        accounts.get(i).Gold_Deductible__c = c.Deductible__c;
                    }
                }
            }
        }
        
        update accounts;
    }
}