public with sharing class CasesListViewComponentController{
    
    public String viewType {get; set;}
    public List<Case> cases {get; set;}


    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('MyClosedCases','My Closed Cases'));
        options.add(new SelectOption('MyCompanyOpenCases','My Company Open Cases'));
        options.add(new SelectOption('MyCompanyClosedCases','My Company Closed Cases'));
        return options;
    }
    
    public CasesListViewComponentController(){
    
    }

    public PageReference casesListView(){
        System.debug('viewType ' + viewType);
        String query = 'SELECT Id, Status, CaseNumber, AccountId, Account.Name, Priority, Description, Type FROM Case ';
        if(viewType.equals('MyClosedCases')){
            String filterPart = 'WHERE Status = \'Closed\'';
            query += filterPart;
        }
        cases = Database.query(query);
        System.debug('cases ' + cases);
        return null;
    }
}