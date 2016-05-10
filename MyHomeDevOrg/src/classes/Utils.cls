public with sharing class Utils {
	public Utils() {
		
	}


	public static String getSObjectFieldsByName(String objName){
		SObjectType objType = Schema.getGlobalDescribe().get(objName);
		return getFields(objType);
	}

	public static String getSObjectFieldsByType(SObjectType objType){
		return getFields(objType);
	}

	public static String getSObjectFieldsByObject(sObject obj){
		return getFields(obj.getSObjectType());
	}	


	private static String getFields(SObjectType objType){
		String result = '';
		Map<String,Schema.SObjectField> mfields = objType.getDescribe().fields.getMap();
		Set<string> fieldSet = mfields.keySet();  
		for(String f : fieldSet) result += mfields.get(f) +',';
		if(result.endsWith(',')) result = result.substring(0,result.length()-1);
		return result;
	}	


}