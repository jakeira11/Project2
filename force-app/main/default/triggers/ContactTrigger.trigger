///////////////////////
//
//Project 2 - JessiCorp
//ContactTrigger
//
///////////////////////



trigger ContactTrigger on Contact (before insert,before update, before delete, after insert, after update, after delete, after undelete) {

    if (Trigger.isBefore){
        if (Trigger.isInsert){
            NewPolicy.updatePrices(Trigger.new);
        } else if (Trigger.isUpdate){
            NewPolicy.updatePrices(Trigger.new);
        }        
    }

}