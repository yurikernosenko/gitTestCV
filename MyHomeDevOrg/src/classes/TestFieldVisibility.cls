public class TestFieldVisibility{
    public JustTestObject__c objectForTest{get; set;}
    public String wrapProp {get; set;} 
    public TestFieldVisibilityWrapper wrapper {get; set;}
    
    /*public Set<Account> accounts {get{
        Set<Account> accounts = new Set<Account>();
        for(Account acc : [SELECT Id FROM Account]){
            accounts.add(acc );
        }
        return accounts;
    } set;}*/
    
    public TestFieldVisibility(){
        objectForTest = [SELECT Id, SimpleTextField__c FROM JustTestObject__c  LIMIT 1];
        wrapProp = objectForTest.SimpleTextField__c;
        wrapper = new TestFieldVisibilityWrapper(objectForTest );
    }
    
    public class TestFieldVisibilityWrapper{
    
        public String wrapPropInWrapper {get; set;}
        
        public TestFieldVisibilityWrapper(sObject obj){
            wrapPropInWrapper = (String)obj.get('SimpleTextField__c');
        }
        
    }
}