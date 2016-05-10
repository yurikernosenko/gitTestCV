public without sharing class CalendarViewController{
    public  Map<Id, YKP__Worker__c> workers {get; set;}
    public List<EventWrapper> eventsForAllUsers {get; set;}
    
    public CalendarViewController(){
        workers  = getAllWorkers();
        eventsForAllUsers  = fillEventWrapper(workers);
    }
    
    public class EventWrapper{
        public String title {get;set;}
        public Boolean allDay {get;set;}
        public String startString {get;set;}
        public String endString {get;set;}
        public String className {get;set;}
    }
    
    private Map<Id, YKP__Worker__c> getAllWorkers(){    
        return new Map<Id, YKP__Worker__c>([SELECT ID FROM YKP__Worker__c]);
    }
    
    private List<EventWrapper> fillEventWrapper(Map<Id, YKP__Worker__c> workers ){
        List<EventWrapper> result = new List<EventWrapper>();
        if(workers.isEmpty()){
            return result;
        }               
        for(YKP__Absence__c absence : [SELECT ID, YKP__Worker_Absence__c, YKP__Worker_Absence__r.Name, YKP__Absence_End_Date__c, YKP__Absence_Start_Date__c, YKP__AbsenceDate__c  FROM YKP__Absence__c WHERE YKP__Worker_Absence__c IN :workers.keySet()]){
            EventWrapper eWrapper = new EventWrapper();
            eWrapper.title = absence.YKP__Worker_Absence__r.Name;
            eWrapper.allDay = (absence.YKP__AbsenceDate__c  == 1) ? true : false;
            eWrapper.startString = String.valueOf( absence.YKP__Absence_Start_Date__c );
            eWrapper.endString = String.valueOf( absence.YKP__Absence_End_Date__c);
            eWrapper.className = 'dayoff';
            
            result.add(eWrapper);
        }
        return result;
    }
}