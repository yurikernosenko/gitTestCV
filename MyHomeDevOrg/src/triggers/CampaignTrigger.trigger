trigger CampaignTrigger on Campaign (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
           init(Trigger.new);
        }
    }
    
    public void init(List<Campaign> campaigns) {
        List<CampaignShare> result = new List<CampaignShare>();
        Set<String> countries = new Set<String>();
        for(Campaign camp: campaigns) {
            if(camp.Country__c != null){
                countries.add(camp.Country__c);
            }
        }

        if(!countries.isEmpty()){
            List<user> users = [SELECT ID, Country FROm User WHERE Country IN : countries];
            if (!users.isEmpty()){
                for(Campaign c: campaigns){
                    for(User u: users){
                        if(c.Country__c == u.Country){
                            CampaignShare cs = new CampaignShare();
                            cs.CampaignId = c.Id;
                            cs.CampaignAccessLevel = 'Edit';
                            cs.RowCause = 'Manual';
                            cs.UserOrGroupId = u.Id; 
                            result.add(cs);
                        }
                    }
                }

                insert result;
            }
        }
        
    }
}