public with sharing class SBC_Fidelity_Controller {

    public static final String WHERE_CLAUSE_WITH_3_PARAMETRS = ' WHERE YKP__Account__r.Name LIKE {1} AND (YKP__Contact__r.MailingCity LIKE {2} OR YKP__Contact__r.MailingCountry LIKE {2})';
    public static final String WHERE_CLAUSE_WITH_COMPANY_NAME_PARAMETR = ' WHERE YKP__Account__r.Name LIKE {1}';
    public static final String WHERE_CLAUSE_WITH_LOCATION_PARAMETR = ' WHERE YKP__Contact__r.MailingCity LIKE {2} OR YKP__Contact__r.MailingCountry LIKE {2}';
    public static final String INDIVIDUAL_PART = '), YKP__Individual__c(Id';
    
    
    public String individualsName {get; set;}
    public String companyName {get; set;}
    public String addressLocation {get; set;}

    public List<YKP__Individual__c> individuals {
        get{
            if(setCon != null){
                return (List<YKP__Individual__c>)setCon.getRecords(); 
            }
            return new List<YKP__Individual__c>();
        } 
        set;
    }
    
    

    public ApexPages.StandardSetController setCon {get; set;}
       
    public SBC_Fidelity_Controller() {
        
    }

    public String validateString(String inputString){
        System.debug('inputString ' + inputString);
        //String result = inputString.replace('[\\? \\& \\| \\! \\{ \\} \\[ \\] \\( \\) \\^ \\~ \\* \\: \\+ \\-  \" \'  \\ ]' , '\\$&');
        String result = inputString.replace('\'' , '\\\'');
        System.debug('result ' + result);

        return result;

    }

    public String returnFuzzyStringForSearch(String inputString){

        if(inputString.containsWhitespace()){
            String result = '';
            List<String> parts =  inputString.trim().split(' ');
            for(String str : parts){
                result += str.trim() + '* OR ';
            }
            result = result.trim().removeEndIgnoreCase('OR');
            return '\''+ result + '\''; 
        }
        return '\''+ inputString + '*\'';
    }
    
    public List<String> getParametrsForQuery(Boolean isDirectStringMatch){
        /*String individualsName = isDirectStringMatch ? '\''+validateString(individualsName)+'\'' : returnFuzzyStringForSearch(validateString(individualsName));        
        String companyName = '\'' + validateString(companyName) + '\'';
        String addressLocation = '\'%' + validateString(addressLocation) + '%\'';
        return new List<String>{individualsName, companyName, addressLocation};*/
        String individualsName = isDirectStringMatch ? '\''+validateString(individualsName)+'\'' : returnFuzzyStringForSearch(validateString(individualsName));        
        return new List<String>{individualsName};
    }

    public String createQuery(String whreClause, Boolean isDirectStringMatch){
        String queryWithParametrs = getBaseSoslStringForQuery() + whreClause + ')';
        String result  = String.format(queryWithParametrs, getParametrsForQuery(isDirectStringMatch));
        return result;
    }

    public PageReference search(){
        
        //individuals.clear();
        Map<Integer, String> indexAndQueryForSearch = new Map<Integer, String>();
        if(String.isNotBlank(companyName) && String.isNotBlank(addressLocation)){
            indexAndQueryForSearch.put(1, createQuery(WHERE_CLAUSE_WITH_3_PARAMETRS, true));
            indexAndQueryForSearch.put(2, createQuery(WHERE_CLAUSE_WITH_3_PARAMETRS, false));
        }
        
        if(String.isNotBlank(companyName) || String.isNotBlank(addressLocation)){
            if(String.isNotBlank(companyName)){
                indexAndQueryForSearch.put(3, createQuery(WHERE_CLAUSE_WITH_COMPANY_NAME_PARAMETR, true));
                indexAndQueryForSearch.put(6, createQuery(WHERE_CLAUSE_WITH_COMPANY_NAME_PARAMETR, false));
            }
            
            if(String.isNotBlank(addressLocation)){
                indexAndQueryForSearch.put(4, createQuery(WHERE_CLAUSE_WITH_LOCATION_PARAMETR, true));
                indexAndQueryForSearch.put(7, createQuery(WHERE_CLAUSE_WITH_LOCATION_PARAMETR, false));
            }
        }
        indexAndQueryForSearch.put(5, createQuery(INDIVIDUAL_PART, true));
        indexAndQueryForSearch.put(8, createQuery(INDIVIDUAL_PART, false));
        List<Integer> indexes = new List<Integer>(indexAndQueryForSearch.keySet());
        indexes.sort();
        Map<Integer, List<List<sObject>>>searchResults = new Map<Integer, List<List<sObject>> >();
        for(Integer index : indexes){
            List<List<sObject>> queryResult = search.query( indexAndQueryForSearch.get(index));
            searchResults.put(index, queryResult);
        }
        
        Set<String> individualsIds = new Set<String>();
        for(Integer index : searchResults.keySet()){
            for(List<sObject> objs : searchResults.get(index)){
                String fieldName;
                if(String.valueOf(objs.getSObjectType()) == 'YKP__Individual__c'){
                    fieldName = 'Id';
                }

                if(String.valueOf(objs.getSObjectType()) == 'YKP__ContactRole__c'){
                    fieldName = 'YKP__Individual__c';
                }
                for(sObject obj : objs){
                    individualsIds.add((String)obj.get(fieldName));
                }
            }   
        }
        
        Map<Id, YKP__Individual__c> searchResult = new Map<Id, YKP__Individual__c>([SELECT Id, Name, YKP__X360Entity_Id_c__c, (SELECT Id, Name FROM YKP__ContactRoles__r) FROM YKP__Individual__c WHERE ID IN :individualsIds]);
        List<YKP__Individual__c> individualsTemp = new List<YKP__Individual__c>();
        for(String individualId : individualsIds){
            individualsTemp.add(searchResult.get(individualId));
        }

        setCon = new ApexPages.StandardSetController(individualsTemp); 
        setCon.setPageSize(1);
        
        return null;
    }

    public String getBaseSoslStringForQuery(){
        String soslQueryBasePart = 'FIND {0} IN NAME FIELDS RETURNING  YKP__ContactRole__c(Id, Name, YKP__Individual__c';
        return soslQueryBasePart;
    }

}