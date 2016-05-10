@isTest
public class testSetupAnnotationTesting{
    
    @testSetup
    static void createAccount(){
        Account testAccount = createTestAccount();
        insert testAccount;
    }
    
    
    @isTest
    private static void testAccountCreation(){
        List<Account> accounts = [SELECT ID FROM Account];
        System.assertEquals(1, accounts.size(), 'Should be one account after insert operation');
    }
    
    
    private static Account createTestAccount(Map<String, String> additionalValues, Boolean isInsert){
        Account acc = createTestAccount();
        if(additionalValues != null){
            for(String apiName : additionalValues.keySet()){
                acc.put(apiName, additionalValues.get(apiName));
            }
        }
        
        if(isInsert){
            insert acc;
        }
        return acc;
    }
    
    private static Account createTestAccount(){
        Account acc = new Account();
        acc.Name = 'Test';
        return acc;
    }
        
}