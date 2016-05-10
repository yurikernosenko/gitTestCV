public class UtilsForRecordType {

    public static String setProperRecordTypeForOutbound(String accRecordType){
        Map<String, RecordType_Mapping__c> mapping = RecordType_Mapping__c.getAll(); 
        if (!mapping.isEmpty()){
            if(!mapping.keySet().contains(accRecordType)){
                 for(RecordType_Mapping__c  value : mapping.values()){
                     if(value.CloneValue__c == accRecordType){
                         return value.Name;
                     } 
                 }
            }
        }
        return accRecordType;
    }
    
    //change accRecordType to GV_Id, if they only update sf acc then not need
    public static String setProperRecordTypeForInbound(String accRecordType, String recordId){
        List<Account> accounts = [SELECT ID, RecordTypeId FROM Account WHERE Id = :recordId];
        if(!accounts.isEmpty()){
            //use static method to get Account 
            if(accounts[0].RecordTypeID == accRecordType){
                return accRecordType;
            } else {
                Map<String, RecordType_Mapping__c> mapping = RecordType_Mapping__c.getAll(); 
                if (!mapping.isEmpty()){
                    if(mapping.keySet().contains(accRecordType)){
                        return mapping.get(accRecordType).CloneValue__c;
                    } 
                }
            }
        }
           
        return accRecordType;
    }
}