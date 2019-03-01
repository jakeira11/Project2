public class DocCtrl {
    
    @AuraEnabled
    public static Doctor__c getDoc(id docId){
        if (!Schema.sObjectType.Doctor__c.isAccessible()){
            throw new AuraHandledException('You cannot access the Doctor object');
        }
        List<Doctor__c> d = [SELECT id, name, phone__c, date_of_birth__c, specialization__c, gender__c, email__c, languages__c
                             FROM Doctor__c 
                             WHERE id = :docId];
        return d[0];
    }
}