public with sharing class iwlIdeaThemesController {
	public IWLWidget__c listview {get; set;}
	

	public Boolean doLoad {
		get {
			if (doLoad == null) {
				listview = IWLWidgetDAO.getRecord('IdeaThemesList');
				Map<String, String> pageParams = Apexpages.currentPage().getParameters();
				String selectedCategory = pageParams.get('category');
				String idsList = pageParams.get('records');
				
				if (selectedCategory != null && selectedCategory != '') {
					listview.useAdvancedFiltering__c = true;
					listview.filterAdvanced__c = 'categories includes (\'' + selectedCategory + '\')';
				} else if (idsList != null && idsList != '') {
					//show only ideas the user has searched for
					listview.useAdvancedFiltering__c = true;
					idsList = '\'' + idsList + '\'';
					idsList = idsList.replaceAll(',', '\',\'');
					listview.filterAdvanced__c = 'Id in (' + idsList + ')';	
				}
				doLoad = true;
			}
			
			return doLoad;
		} set;
	}
}