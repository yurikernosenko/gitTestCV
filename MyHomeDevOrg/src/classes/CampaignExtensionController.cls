public class CampaignExtensionController {
   
    public static Campaign obj;
    public static Boolean flag {get {return true;} set;}
    
    public CampaignExtensionController(ApexPages.StandardController controller) {
        obj = (Campaign) [Select Id, Country__c FROM Campaign WHERE Id = :controller.getRecord().Id LIMIT 1];
        System.debug('Test ' + obj);
    }
        
    public static PageReference redirToPropperPage(){
        
        System.debug('redirToPropperPage ' + obj);
        
        User u = [SELECT Country FROM User WHERE Id = :userInfo.getUserId() LIMIT 1];
        PageReference pg;
        if(obj.Country__c != u.Country){
            pg = new PageReference('/'+String.valueOf(obj.Id).left(3));
            pg.setRedirect(true);
        } 
        return pg;
    }
}