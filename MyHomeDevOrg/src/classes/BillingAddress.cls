public class BillingAddress {
    private Account acc {get; set;}
    
    public BillingAddress (ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
        System.debug('Account is ++++ ' + acc);
        getAccountFields(acc.Id);
        System.debug('Account is ++++ ' + acc);
    }
    
    private void getAccountFields(Id id){
        acc = [SELECT Id, RecordTypeId, RecordType.DeveloperName, BillingCity, BillingStreet, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id = :id];
    }
}