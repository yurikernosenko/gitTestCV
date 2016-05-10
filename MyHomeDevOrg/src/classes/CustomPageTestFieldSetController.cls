public with sharing class CustomPageTestFieldSetController {
	
	public JustTestObject__c obj {get; set;}

	public List<JustTestObject__c> objects {get; set;}

	public List<String> fieldSetFields;

	public CustomPageTestFieldSetController() {
		obj = new JustTestObject__c();
		objects = [SELECT Id, isActive__c FROM JustTestObject__c];
	}

	public List<String> getFieldSetFields(){
		List<String> result = new List<String>();
		List<Schema.FieldSetMember> fieldSet = SObjectType.JustTestObject__c.FieldSets.CheckBoxTest.getFields();
		for(Schema.FieldSetMember member: fieldSet){
			result.add(member.getFieldPath());
		}
		return result;
	}

	public PageReference save(){

		insert obj;
		return null;
	}
}