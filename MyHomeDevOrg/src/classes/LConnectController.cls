public class LConnectController{
    
    @AuraEnabled
    public static List<YKP__ApplicationOptionMenu__c> getOptionsForMenu(){
        List<YKP__ApplicationOptionMenu__c> result = new  List<YKP__ApplicationOptionMenu__c>([SELECT ID, YKP__OptionLabel__c, YKP__OptionValue__c, YKP__SequenceNumber__c  FROM YKP__ApplicationOptionMenu__c ORDER BY YKP__SequenceNumber__c ASC]);
        return result;
    }
        
    @AuraEnabled
    public static List<YKP__L_AppMenuComponent__c> getOptionsForAppMenu(String menuType){
        System.debug('In getOptionsForAppMenu');
        List<YKP__L_AppMenuComponent__c> result = new  List<YKP__L_AppMenuComponent__c>(
            [
                SELECT 
                    ID, YKP__ManuItemLabel__c, YKP__SequenceNumber__c,
                    (SELECT ID, YKP__ComponentApiName__c, YKP__ComponentID__c FROM YKP__ComponentRegistrations__r)
                FROM 
                    YKP__L_AppMenuComponent__c 
                WHERE
                    YKP__ManuName__r.YKP__MenuType__c = :menuType AND
                    YKP__ManuName__r.YKP__ApplicationType__c = 'Connect'
                ORDER BY YKP__SequenceNumber__c ASC]);
        return result;
    }
}