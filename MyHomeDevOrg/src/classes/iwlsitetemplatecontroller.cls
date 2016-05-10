public with sharing class iwlsitetemplatecontroller {


	public Boolean load {
		get {
			if (load == null) {
				load = IWLWidgetManager.generateDefaultWidgets;
			}
			return load;
		} set;
		
	}
}