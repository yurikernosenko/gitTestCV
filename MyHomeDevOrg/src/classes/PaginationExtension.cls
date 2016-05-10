public class PaginationExtension {
    
    public List<Account> accounts {get{
        if(accounts == null){
            accounts = new List<Account>();
        }
        return accounts;
    } 
    set;}
    
    public ApexPages.StandardSetController setCon {get; set;}
        /*get{
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(accounts);
                // sets the number of records in each page set
                con.setPageSize(5);
            }
            return con;
        }
        set;}*/
    
    public pageReference start(){
        List<Account> acc = [Select Name, Type, BillingCity, BillingState, BillingCountry, (SELECT Id, LastName FROM Contacts) from Account];
        setCon = new ApexPages.StandardSetController(acc); //Database.getQueryLocator(queryString)
        setCon.setPageSize(4);
        return null;
    }

    public List<Account> getAccounts(){
        List<Account> accounts = new List<Account>();
        for(Account a : (List<Account>)setCon.getRecords())
            accounts.add(a);
        return accounts;
    }
    
    /*public pageReference refresh() {
        setCon = null;
        getAccounts();
        setCon.setPageNumber(1);
        return null;
    }*/
    
    /*public class AccountWrapper {
        public Integer index {get; set;}
        public Account acc {get; set;}
        public String wrapperToJSON {get; set;}
        
        public AccountWrapper(integer index, Account acc, String wrapperToJSON){
            this.index = index;
            this.acc = acc;
            this.wrapperToJSON = wrapperToJSON;
        }
    }*/
}