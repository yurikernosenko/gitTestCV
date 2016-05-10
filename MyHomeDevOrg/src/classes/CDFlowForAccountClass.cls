public with sharing class CDFlowForAccountClass{
    
    @InvocableMethod
    public static List<String> getAccountsName(List<String> param){
        List<String> names = new List<String>();
        for(Account a: [SELECT Name FROM Account LIMIT 10]){
            names.add(a.Name);
        }
        return names;
    }
}