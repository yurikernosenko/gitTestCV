public class PaginationDemoController {
    public CustomPaginator paginater {get;set;} 
    public List<Account> accounts{get;set;} 
    public List<List<Account>> fullGenericList{get;set;} 
    public PaginationDemoController(){ 
        //Get the data we need to paginate 
        List<Account> resultsList = [SELECT Id, Name FROM Account]; 
        //Set the page size 
        Integer pageSize = 5; 
        //Create a new instance of Paginate passing in the overall size of the list of data and the page size you want 
        this.paginater = new CustomPaginator(resultsList.size(), pageSize); 
        //These lists hold the data 
        this.fullGenericList = new List<List<Account>>(); 
        this.accounts = new List<Account>(); 
        //Break out the full list into a list of lists 
            if(resultsList.size() > 0){ 
                List<Account> tempCC = new List<Account>(); 
                Integer i = 0; 
                for(Account cc : resultsList){ 
                    tempCC.add(cc); 
                    i++; 
                    if(i == pageSize){ 
                        this.fullGenericList.add(tempCC); 
                        tempCC = new List<Account>(); 
                        i = 0; 
                    } 
                } 
                if(!tempCC.isEmpty()){ 
                    this.fullGenericList.add(tempCC); 
                } 
                //Gets the correct list of data to show on the page 
                this.accounts = this.fullGenericList.get(this.paginater.index); 
            } 
    } 
    
    public PageReference previousPage(){ 
        this.paginater.decrement(); 
        return changeData(); 
    } 
    
    public PageReference nextPage(){ 
        this.paginater.increment(); 
        return changeData(); 
    } 
    
    public PageReference updatePage(){ 
        this.paginater.updateNumbers(); 
        return changeData(); 
    } 
    public PageReference changeData(){ 
        this.accounts = this.fullGenericList.get(this.paginater.index); 
        return null; 
    } 
                        
}