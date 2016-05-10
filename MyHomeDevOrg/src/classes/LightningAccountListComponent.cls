public with sharing class LightningAccountListComponent extends LightningComponentControllerBase {
    
    @AuraEnabled
    public static list<Account> getAccounts(){
        return [SELECT Id, Name FROM Account LIMIT 10];
    }
    
}