public with sharing class IWLWidgetManager {

	public static final String IdeasList = 'IdeasList';
	public static final String IdeasForTheme = 'IdeasForTheme';
	public static final String IdeaThemesList = 'IdeaThemesList';
	public static final String MainSlideshow = 'MainSlideshow';
	public static final String PostIdeaHome = 'PostIdeaHome';
	public static final String IdeasListHome = 'IdeasListHome';
	public static final String IdeaDetail = 'IdeaDetail';
	public static final String IdeaThemeDetail = 'IdeaThemeDetail';
	public static final String PostToTheme = 'PostToTheme';
	public static final String ProfileImageEdit = 'ProfileImageEdit';
	public static final String SearchIdeas = 'SearchIdeas';
	public static final String Leaderboard = 'Leaderboard';
	public static final String UserDetail = 'UserDetail';
	
	

	private static Map<String, IWLWidget__c> widgets {get; set;}
	
	public static IWLWidget__c getWidget(String developerName) {
		if (widgets == null) widgets = new Map<String, IWLWidget__c>();
		
		if (widgets.containsKey(developerName)) return widgets.get(developerName);
		
		IWLWidget__c newWidgetRecord = IWLWidgetDAO.getRecord(developerName);
		
		widgets.put(developerName, newWidgetRecord);
		
		return newWidgetRecord;
		
	} 
	
	public static Map<String, String> DefaultWidgetDeveloperNames {
		get {
			if (DefaultWidgetDeveloperNames == null) {
				DefaultWidgetDeveloperNames = new Map<String, String>();
				DefaultWidgetDeveloperNames.put(IdeasList, IdeasList);
				DefaultWidgetDeveloperNames.put(IdeasForTheme, IdeasForTheme);
				DefaultWidgetDeveloperNames.put(IdeaThemesList, IdeaThemesList);
				DefaultWidgetDeveloperNames.put(MainSlideshow, MainSlideshow);
				DefaultWidgetDeveloperNames.put(PostIdeaHome, PostIdeaHome);
				DefaultWidgetDeveloperNames.put(IdeasListHome, IdeasListHome);
				DefaultWidgetDeveloperNames.put(IdeaDetail, IdeaDetail);
				DefaultWidgetDeveloperNames.put(IdeaThemeDetail, IdeaThemeDetail);
				DefaultWidgetDeveloperNames.put(PostToTheme, PostToTheme);
				DefaultWidgetDeveloperNames.put(ProfileImageEdit, ProfileImageEdit);
				DefaultWidgetDeveloperNames.put(SearchIdeas, SearchIdeas);
				DefaultWidgetDeveloperNames.put(Leaderboard, Leaderboard);
				DefaultWidgetDeveloperNames.put(UserDetail, UserDetail);
			}
			return DefaultWidgetDeveloperNames;
		} set;
	}
	
	public static Boolean generateDefaultWidgets {
		get {
			if (generateDefaultWidgets == null) {
				List<IWLWidget__c> existingDefaultWidgets = [Select Id, DeveloperName__c from IWLWidget__c where DeveloperName__c IN :DefaultWidgetDeveloperNames.values() limit :DefaultWidgetDeveloperNames.size()];
				Map<String, String> missingDefaultWidgetsNames = new Map<String, String>(DefaultWidgetDeveloperNames);
				List<IWLWidget__c> missingDefaultWidgets = new List<IWLWidget__c>();
				if (existingDefaultWidgets.size() != DefaultWidgetDeveloperNames.size()) {
					for (IWLWidget__c existingWidget : existingDefaultWidgets) {
						if (missingDefaultWidgetsNames.containsKey(existingWidget.DeveloperName__c)) {
							missingDefaultWidgetsNames.remove(existingWidget.DeveloperName__c);
						}
					}
					
					for (String missingWidgetName : missingDefaultWidgetsNames.values()) {
						missingDefaultWidgets.add(generateDefaultWidget(missingWidgetName));
					}
					if (missingDefaultWidgets.size() > 0) {
						insert missingDefaultWidgets;
					}
				}
				
				generateDefaultWidgets = true;
			}
			return generateDefaultWidgets;
		} set;
		
		
	}
	
	public static IWLWidget__c generateDefaultWidget(String developerName) {
		IWLWidget__c record = null;
		String communityId = IWLTestUtilities.getCommunity().Id;
		record = new IWLWidget__c(DeveloperName__c = developerName, 
							Title__c= developerName, 
							Community__c = communityId, 
							Name = developerName, 
							description__c = null, 
							OrderByBasic__c = IWLCodeSettings.OrderByPicklistCreatedDateLabel, 
							overrideCSS__c = false, 
 							sortOrder__c = IWLCodeSettings.SortOrderPicklistDescendingLabel, 
 							listSize__c = 10, 
 							seeMoreUrl__c = null, 
 							detailPageUrl__c = '',  
 							transitionInterval__c = 0, 
 							authorDetailUrl__c = '', 
 							useAdvancedFiltering__c = false,
 							filterAdvanced__c  = null, 
 							orderByAdvanced__c = null, 
 							emptyAvatarImageUrl__c = '',
 							contentLength__c = 300,
 							relatedFeedSize__c = 3, 
 							showRichText__c = true, 
 							showPagination__c = true, 
 							showRelatedFeed__c = true, 
 							votePanel__c = true, 
 							viewType__c = IWLCodeSettings.ViewtypePicklistDetailedLabel, 
 							additionalFields__c = '', 
 							RedirectURL__c = '', 
 							twoStepIdea__c = false,
 							showLabels__c = false, 
 							avatarsFolderDevName__c = null,
 							loadMerged__c = false,
 							loadUserStats__c = true
		);
		
		if (developerName == IdeasList) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.ListviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaDetail';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaLabel;
			
		} else if (developerName == IdeasForTheme) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.ListviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaDetail';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaLabel;
			record.useAdvancedFiltering__c = true;
			record.filterAdvanced__c = 'IdeaThemeId=';
			record.orderByAdvanced__c = 'CreatedDate DESC';
		} else if (developerName == IdeaThemesList) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.ListviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaThemeDetail?it=1&';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaThemeLabel;
			record.relatedFeedSize__c = null;
		} else if (developerName == MainSlideshow) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.SlideshowRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaThemeDetail?it=1&';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaThemeLabel;
			record.relatedFeedSize__c = null;
			record.listSize__c =3;
			record.transitionInterval__c = 10;
			record.seeMoreUrl__c = null;
		} else if (developerName == PostIdeaHome) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.PostIdeaRecordTypeName).Id;
			record.Title__c = null;
			record.twoStepIdea__c = true;
			record.transitionInterval__c = 0;
			
			record.Redirect__c = true;
			record.RedirectURL__c = '/apex/iwlIdeaDetail';
			
		} else if (developerName == IdeasListHome) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.ListviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaDetail';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaLabel;
			record.listSize__c = 6;
			record.votePanel__c = false;
			record.showRelatedFeed__c = false;
			record.OrderByBasic__c = IWLCodeSettings.OrderByPicklistCommentsCountLabel;
		} else if (developerName == IdeaDetail) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.DetailviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaDetail';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaLabel;
			record.showLabels__c = true;
		} else if (developerName == IdeaThemeDetail) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.DetailviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaThemeDetail?it=1&';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaThemeLabel;
			record.showLabels__c = true;
		} else if (developerName == PostToTheme) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.PostIdeaRecordTypeName).Id;
			record.Title__c = null;
			record.twoStepIdea__c = true;
			record.transitionInterval__c = 0;
			
			record.Redirect__c = true;
			record.RedirectURL__c = null;
		} else if (developerName == ProfileImageEdit) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.AvatarUploadRecordTypeName).Id;
			record.Title__c = 'Edit your profile';
			
		} else if (developerName == SearchIdeas) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.SearchRecordTypeName).Id;
			record.Title__c = 'Search Ideas';
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlIdeaDetail';
			record.Origin__c = IWLCodeSettings.OriginPicklistIdeaLabel;
			record.Redirect__c = true;
			record.RedirectURL__c = '/apex/iwlIdeas';
		} else if (developerName == Leaderboard) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.ListviewRecordTypeName).Id;
			record.Title__c = 'LEADERBOARD';
			record.description__c = 'Check out the top ten point scorers for last month';
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlUserProfile';
			record.seeMoreUrl__c = '/apex/iwlUsers';
			record.showLabels__c = true;
			record.viewType__c = IWLCodeSettings.ViewtypePicklistSummaryLabel;
			record.Origin__c = IWLCodeSettings.OriginPicklistUserLabel;
			
		} else if (developerName == UserDetail) {
			record.RecordTypeId = IWLTestUtilities.getIWLRecordType(IWLCodeSettings.DetailviewRecordTypeName).Id;
			record.Title__c = null;
			record.authorDetailUrl__c = '/apex/iwlUserProfile';
			record.detailPageUrl__c = '/apex/iwlUserProfile';
			record.Origin__c = IWLCodeSettings.OriginPicklistUserLabel;
			record.showLabels__c = true;
		}
		return record;
		
	}
	
	@isTest
	private static void testWidgetManager() {
		Test.startTest();
		
		system.assert(IWLWidgetManager.generateDefaultWidgets);
		system.assert(IWLWidgetManager.getWidget(Leaderboard) != null);
		Test.stopTest();
	}
 
}