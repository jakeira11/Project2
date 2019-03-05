trigger FamilyTrigger on Family__c (before insert,before update, before delete, after insert, after update, after delete, after undelete) {

    if (Trigger.isBefore){

        if (Trigger.isInsert){

        } else if (Trigger.isUpdate){

        } else if (Trigger.isDelete){
            //DOES NOT WORK NEED FIX
            /*List<Id> policyHolderIDs = new List<Id>();
            for (Family__c f : Trigger.old){
                policyHolderIDs.add(f.Policy_Holder__c);
            }
            List<Contact> cons = new List<Contact>();
            for(Contact c : [SELECT id FROM Contact WHERE id IN :policyHolderIDs]){
                cons.add(c);
            }
            NewPolicy.updatePrices(cons);*/

        }
        
    } else if (Trigger.isAfter){

        if (Trigger.isInsert){

        } else if (Trigger.isUpdate){

        } else if (Trigger.isDelete){
        }

    }

}