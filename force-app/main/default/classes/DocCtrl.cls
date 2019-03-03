public class DocCtrl {
    
    @AuraEnabled
    public static Doctor__c getDoc(id docId){
        if (!Schema.sObjectType.Doctor__c.isAccessible()){
            throw new AuraHandledException('You cannot access the Doctor object');
        }
        List<Doctor__c> d = [SELECT id, name, phone__c, date_of_birth__c, specialization__c, gender__c, email__c, language__c
                             FROM Doctor__c 
                             WHERE id = :docId];
        return d[0];
    }

    @AuraEnabled
    public static List<Appointment__c> getAppList(id docId){
        if (!Schema.sObjectType.Appointment__c.isAccessible()){
            throw new AuraHandledException('You cannot access the Doctor object');
        }
        List<Appointment__c> a = [SELECT id, name, doctor__c, appointment_time__c, 
                                         patient__r.name, patient__r.email, patient__r.phone,
                                         patient__r.MailingStreet, patient__r.MailingState, patient__r.MailingCity,
                                         patient__r.MailingPostalCode,  patient__r.MailingCountry,
                                         practice__r.Name, practice__r.Street__c, practice__r.City__c,
                                         practice__r.State__c, practice__r.ZIP__c
                                  FROM Appointment__c 
                                  WHERE doctor__c = :docId
                                  ORDER BY appointment_time__c ASC];
        return a;
    }
}