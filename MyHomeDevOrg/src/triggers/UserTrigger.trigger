trigger UserTrigger on User (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
        	init(Trigger.new);
        }
        
        if(Trigger.isUpdate){
            init(Trigger.newMap, Trigger.oldMap);
        }
    }
    
    public void init(List<User> users){
        List<User> result = new List<User>();
        for(User usr : users){
            if(usr.Country != null){
                result.add(usr);
            }
        }
        if(!result.isEmpty()){
            proceedWithRecords(new Map<Id, User>(result));
        } 
    }
    
    public void init(Map<Id,User> newMap, Map<Id, User> oldMap){
        Map<Id,User> result = new Map<Id,User>();
        Map<Id,User> usersToDeleteSharrings = new Map<Id,User>();
        for(Id userId : newMap.keySet()){
            if(newMap.get(userId).Country != null && newMap.get(userId).Country != oldMap.get(userId).Country){
                usersToDeleteSharrings.put(userId, oldMap.get(userId));
                result.put(userId, newMap.get(userId));
            }
        }
        if(!usersToDeleteSharrings.isEmpty()){
            deleteCampaignSharringsForUsers(usersToDeleteSharrings);
        }
        if(!result.isEmpty()){
            proceedWithRecords(result);
        } 
    }
    
    public Set<String> getCountries(Map<Id, User> users){
        Set<String> countries = new Set<String>();
        for(User usr: users.values()){
            countries.add(usr.Country);
        } 
        return countries;
    }
    
    public void deleteCampaignSharringsForUsers (Map<Id, User> users){
        Set<String> countries = getCountries(users);
        List<CampaignShare> cs = [SELECT Id FROm CampaignShare WHERE UserOrGroupId IN :users.keySet() AND RowCause != 'Owner'];
        Database.delete(cs, false);
    } 
    
    public void proceedWithRecords(Map<Id, User> users){
        List<CampaignShare> result = new List<CampaignShare>();
        Set<String> countries = getCountries(users);
        List<Campaign> campaigns = [SELECT ID, Country__c FROm Campaign where Country__c IN :countries];
        if(!campaigns.isEmpty()){
            for(Id ids: users.keySet()){
                for(Campaign camp: campaigns){
                    if(users.get(ids).Country == camp.Country__c){
                        CampaignShare cs = new CampaignShare();
                        cs.CampaignId = camp.Id;
                        cs.CampaignAccessLevel = 'Edit';
                        cs.RowCause = 'Manual';
                        cs.UserOrGroupId = ids;
                        result.add(cs);
                    }
                }
            }
            insert result;
        }
    }
}