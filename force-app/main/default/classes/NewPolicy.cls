public class NewPolicy {
    public static void updatePrices(Map<Id,Contact> cons,Map<Id,Contact> old){
        for (Id i : Cons.keyset()){
            Contact c = cons.get(i);
            if (c.Customized__c == false && c.Tier__c == 'Bronze' && c.Tier__c != old.get(i).Tier__c){
                c.Premium__c = 500 + (100 * c.Spouse__c) + (150 * c.Dependents__c);
                c.Coverage_Cap__c = 1500;
                c.Deductible__c = 1000;
            }
            if (c.Customized__c == false && c.Tier__c == 'Silver' && c.Tier__c != old.get(i).Tier__c){
                c.Premium__c = 1000 + (110 * c.Spouse__c) + (200 * c.Dependents__c);
                c.Coverage_Cap__c = 2000;
                c.Deductible__c = 600;
            }
            if (c.Customized__c == false && c.Tier__c == 'Gold' && c.Tier__c != old.get(i).Tier__c){
                c.Premium__c = 1500 + (120 * c.Spouse__c) + (250 * c.Dependents__c);
                c.Coverage_Cap__c = 2250 + ((c.Spouse__c + c.Dependents__c) * 150);
                c.Deductible__c = 300;
            }
        }
        
    }
}