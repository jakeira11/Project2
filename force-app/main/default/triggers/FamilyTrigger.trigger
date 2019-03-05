trigger FamilyTrigger on Family__c (before insert,before update, before delete, after insert, after update, after delete, after undelete) {

    if (Trigger.isBefore){

        if (Trigger.isInsert){

        } else if (Trigger.isUpdate){

        } else if (Trigger.isDelete){

            //On delete of family record(s), update all contacts
            List<Contact> cons = new List<Contact>();
            for(Contact c : [SELECT id FROM Contact]){
                cons.add(c);
            }
            update cons;
        }
        
    } else if (Trigger.isAfter){

        if (Trigger.isInsert){

        } else if (Trigger.isUpdate){

        } else if (Trigger.isDelete){
        }

    }

}