public with sharing class iwlIdeaThemeDetailController {
	
	
	public IWLWidget__c widgetRecord {get; set;}
	public String themeId {get; set;}
	public String message {get; set;}
	
	public iwlIdeaThemeDetailController() {
		
		themeId = Apexpages.currentPage().getParameters().get('id');
	}
	
	public Boolean doLoad {
		get {
			if (doLoad == null) {
				try {
					
						widgetRecord = IWLWidgetDAO.getRecord('IdeasForTheme');
						
						widgetRecord.filterAdvanced__c += '\'' + themeId + '\'';
						message = widgetRecord.filterAdvanced__c;
						doLoad = true;
					
				} catch (Exception ex) {
					doLoad = false;
				}
			}
			return doLoad;
		} set;
	}
}