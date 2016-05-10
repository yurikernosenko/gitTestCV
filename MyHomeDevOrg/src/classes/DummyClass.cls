public with sharing class DummyClass {

    public String view {get; set;}
    public List<Case> cases {get; set;}

    public String userName {get{
        return UserInfo.getName();
    } set;}

    public String userId {get{
        return UserInfo.getUserId();
    } set;}

    public String profileName {get{
        return UserInfo.getUserId();
    } set;}

    public String userType {get{
        return UserInfo.getUserType();
        }
    }

    public List<User> users {
        get{
            return [SELECT Id, FirstName, ProfileId, Profile.Name, ContactId, Contact.AccountId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];            
        }
    }

    public Map<String, String> options {
        get{
            Map<String, String> result = new Map<String, String>();
            User currentUser = [SELECT Id, FirstName, ProfileId, Profile.Name FROm User WHERE Id =: UserInfo.getUserId() LIMIT 1];
                result.put('My Open Cases', 'MyOpenCases');
                result.put('My Closed Cases', 'MyClosedCases');
                if(users[0].Profile.Name == 'SuperCommunityUser'){
                    result.put('My Company Open Cases', 'MyCompanyOpenCases');
                    result.put('My Company Closed Cases', 'MyCompanyClosedCases');
                }
            return result;
        }
    }



    public DummyClass() {

    }

    public PageReference showCases(){
        String status = (view == 'MyOpenCases' || view == 'MyCompanyOpenCases') ? 'Open' : 'Closed';
        Boolean isCompany = (view == 'MyCompanyOpenCases' || view == 'MyCompanyClosedCases') ? true : false;

        cases = getCases(status, isCompany);
        System.debug('Cases is ' + cases);

       /* if(view == 'MyOpenCases' && users[0].ContactId != null){
            stringQuery += ' WHERE case.ContactId =\'' + users[0].ContactId + '\' AND Status = \'New\'';
            System.debug('query is ' + stringQuery);
            cases = Database.query(stringQuery);
        } else {
            if(view == 'MyClosedCases'){

            }
        }*/
        return null;
    }

    public List<Case> getCases(String statusValue, Boolean isCompany){
        String stringQuery = 'SELECT ID, CaseNumber, Status FROm Case';
        List<Case> result = new List<Case>();
        
        String filterId = (isCompany == true) ? 
            'Contact.AccountId =\'' + users[0].Contact.AccountId + '\' ' :
            'ContactId =\'' + users[0].ContactId + '\'';

        String statusFilter = (statusValue == 'Open') ?
            ' AND Status != \'Closed\'' :
            ' AND Status = \'Closed\'';
            
        
        stringQuery += ' WHERE ' + filterId + statusFilter;
        System.debug('w ' + stringQuery);
        result = Database.query(stringQuery);
        return result;
    }
}