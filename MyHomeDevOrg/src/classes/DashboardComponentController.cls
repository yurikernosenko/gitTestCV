public with sharing class DashboardComponentController {
    
    public String firstParametr{get; set;}
    public String secondParametr{get; set;}
    
    public User currentUser = [SELECT Id, FirstName, ProfileId, Profile.Name, ContactId, Contact.AccountId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];    
    
    public List<PieWedgeData> chartPieElements {
        get{
            chartPieElements= new List<PieWedgeData>();
            if(firstParametr !=null){
                List<AggregateResult> casesByStatus = getQueryResult(firstParametr );
                if(!casesByStatus.isEmpty()){

                    for(AggregateResult ag: casesByStatus ){
                        chartPieElements.add(new PieWedgeData(String.valueOf(ag.get('Status')), Integer.valueOf(ag.get('expr0'))));
                    }
                }
            } 
                        System.debug('chartPieElements' + chartPieElements);
            return  chartPieElements;
        } 
        set;
    }
    
    public List<PieWedgeData> chartBarElements {
        get{
            chartBarElements = new List<PieWedgeData>();
            if(secondParametr!=null){
                List<AggregateResult> casesByPriority = getQueryResult(secondParametr);
                                                        System.debug('casesByPriority ' + casesByPriority );
                if(!casesByPriority.isEmpty()){
                System.debug('In ' + chartBarElements);
                    for(AggregateResult ag: casesByPriority ){
                        chartBarElements.add(new PieWedgeData(String.valueOf(ag.get(secondParametr)), Integer.valueOf(ag.get('expr0'))));
                        System.debug('In ' + chartBarElements );
                    }
                }
            } 
            System.debug('chartBarElements  ' + chartBarElements );
            return  chartBarElements ;
        } 
        set;
    }
 
    public List<AggregateResult> getQueryResult(String fieldType){
        String queryString = 'SELECT COUNT(Id), ' + fieldType + ' FROM Case';
        if(currentUser.ContactId != null){
            queryString += ' WHERE Contact.Id = \'' + currentUser.ContactId + '\'  Group By ' + fieldType + '';
        } else return new List<AggregateResult>();
        //queryString += ' Group By ' + fieldType + '';
        System.debug('queryString  ' + queryString );
        
        
        return Database.query(queryString );
        //return Database.query('SELECT COUNT(Id), ' + fieldType + ' FROM Case Group By ' + fieldType + '');
    }
 
    public DashboardComponentController() {
        
    }
    
    
    public class PieWedgeData {
        public String name { get; set; }
        public Integer data { get; set; }

        public PieWedgeData(String name, Integer data) {
            this.name = name;
            this.data = data;
        }
    }
}