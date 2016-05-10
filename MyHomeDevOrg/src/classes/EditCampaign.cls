public class EditCampaign{
    
    public String profileName;
    public static final Set<String> profileNames = new Set<String>{'ReadOnly'};
    
    public void EditCampaign(){
        Id profileId = userinfo.getProfileId();
        profileName = [Select Id, Name FROM Profile WHERE Id =: profileId].Name;
    }
    
    public PageReference redirectToEditPage(){
        String url = '/';
        
        if(!profileNames.contains(profileName)){
            url = '003/e';
        } 
        
        PageReference result = new PageReference(url);
        result.setRedirect(true);
        return result;
    }
}