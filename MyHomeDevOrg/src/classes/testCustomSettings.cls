@isTest(SeeAllData=false)
public class testCustomSettings{
    private static Account acc;
    private static final String testRTWRONG = '01220000000MbqtAAC';
    private static final String testRTClone = '0122000000033nyAAA';
    private static final String testRTSame = '0122000000033TAAAY';
    
    static{
        acc = new Account();
        acc.Name = 'Test1';
        acc.RecordTypeId = [SELECT Id FROM RecordType WHERE sobjectType = 'Account' And DeveloperName = 'Acc' LIMIT 1].Id;
        insert acc;
        acc = [SELECT Id, RecordTypeID FROM Account WHERE Id = :acc.Id];
    }
    
    private static testMethod void ifRTTheSameTest(){
        System.assertEquals(acc.RecordTypeId, testRTSame);
    }
    
    private static testMethod void ifRTNOTTheSameCloneTest(){
        
    
    }
    

}