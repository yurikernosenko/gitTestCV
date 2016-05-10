public with sharing class CaseListController{
    
    public String searchText {get; set;}
    public List<Case> cases {get;set;}
    public List<CaseWrapper> caseObject;
    public Integer count {get;set;}
    public Integer index = 5;
    public Integer start = 0;
     
    public Boolean nextBool {get;set;}
    public Boolean prevBool {get;set;}
    
    public List<Case> casesList= new List<Case>();
    public CaseListController(){
        casesList = [SELECT CaseNumber, Type, Status, Priority FROM Case];
        count = [SELECT Count() FROM Case];
        List<Case> temp = new List<Case>();
        for(Integer i = start; i<index; i++)
        {        
            temp.add(casesList.get(i));
        }
        cases = temp;
        prevBool = true;
        nextBool = false;
    }
    
    public PageReference search(){
        System.debug('searchText ' + searchText );
        return null;
    }
    
    public List<CaseWrapper> getCaseObject(){
        caseObject = new List<CaseWrapper>();
        caseObject.add(new CaseWrapper('Open', 15));
        caseObject.add(new CaseWrapper('Closed', 25));
        return caseObject;
    }
    
    public class CaseWrapper{
        public String name {get; set;}
        public Integer data {get; set;}
        
        public CaseWrapper(String name, Integer data){
            this.name = name;
            this.data = data;
        }
    }
    
    public void next()
    {
        index = index + 5;
        start = start + 5;
        cases.clear();
        if(index > count)
        {
            index = Math.Mod(count,5) + start;
            system.debug('Index is ' + index);
            nextBool = true;
            prevBool = false;
            List<Case> temp = new List<Case>();
            for(Integer i = start; i<index; i++)
            {        
                temp.add(casesList.get(i));
            }
            cases = temp;         
            index = start + 5;    
        }
        else
        {
            List<Case> temp = new List<Case>();
            for(Integer i = start; i<index; i++)
            {        
                temp.add(casesList.get(i));
            }
            cases = temp;     
            prevBool = false;
        }   
    }
    
    public void previous()
    {
        if(start > 5)
        {    
            index = index - 5;
            start = start - 5;
            List<Case> temp = new List<Case>();
            for(Integer i = start; i<index; i++)
            {        
                temp.add(casesList.get(i));
            }
            cases = temp; 
            prevBool = false;
            nextBool = false;
        }    
        else
        {
            index = index - 5;
            start = start - 5;
            List<Case> temp = new List<Case>();
            for(Integer i = start; i<index; i++)
            {        
                temp.add(casesList.get(i));
            }
            cases = temp; 
            prevBool = true;
            nextBool = false;        
        }   
    }
}