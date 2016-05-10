public with sharing class AccountAddressController extends BaseController {
    
    public AccountAddressController() {
        this.componentControllerBaseInstance = new ShowAddressSectionComponentController();
    }

	public void someTest(){
		System.debug('dfgdfg');
	}

	public void someTest2(){
		System.debug('dfgdfg');
		System.debug('Test1');
	}
	
	public List<Account> getAccountsByName(String accountName){
		return [SELECT ID FROM Account WHERE Name = :accountName];
	}

}