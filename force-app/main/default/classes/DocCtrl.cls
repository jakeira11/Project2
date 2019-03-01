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

    @AuraEnabled
    public static List<Appointment__c> getAppList(id docId){
        if (!Schema.sObjectType.Appointment__c.isAccessible()){
            throw new AuraHandledException('You cannot access the Doctor object');
        }
        List<Appointment__c> a = [SELECT id, name, doctor__c, patient__c, appointment_time__c, location__c, 
                                         patient__r.name, patient__r.email, patient__r.phone
                                  FROM Appointment__c 
                                  WHERE doctor__c = :docId];
        return a;
    }
}