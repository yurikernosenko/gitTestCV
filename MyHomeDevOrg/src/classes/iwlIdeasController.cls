public with sharing class iwlIdeasController {
	
	public IWLWidget__c listview {get; set;}
	
	public iwlIdeasController() {
		
		
	}
	
	public Boolean doLoad {
		get {
			if (doLoad == null) {
				listview = IWLWidgetDAO.getRecord('IdeasList');
				Map<String, String> pageParams = Apexpages.currentPage().getParameters();
				String selectedCategory = pageParams.get('category');
				String idsList = pageParams.get('records');
				Boolean showMyIdeas = pageParams.get('mine') != null;
				if (selectedCategory != null && selectedCategory != '') {
					listview.useAdvancedFiltering__c = true;
					listview.filterAdvanced__c = 'categories includes (\'' + selectedCategory + '\')';
				} else if (idsList != null && idsList != '') {
					//show only ideas the user has searched for
					listview.useAdvancedFiltering__c = true;
					idsList = '\'' + idsList + '\'';
					idsList = idsList.replaceAll(',', '\',\'');
					listview.filterAdvanced__c = 'Id in (' + idsList + ')';	
				} else if (showMyIdeas) {
					listview.useAdvancedFiltering__c = true;
					listview.filterAdvanced__c = 'CreatedById = \''+ Userinfo.getUserId() + '\'';
				}
				doLoad = true;
			}
			
			return doLoad;
		} set;
	}
}