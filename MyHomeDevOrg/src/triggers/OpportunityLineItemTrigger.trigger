trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert) {
	System.debug('OpportunityLineItemTrigger after insert new list ' + Trigger.new);
	Set<Id> ids = new Set<Id>();
	for(OpportunityLineItem lineItem: Trigger.new){
		ids.add(lineItem.opportunityId);
	}

	List<Opportunity> opp = [SELECT ID, OppLineItemCount__c FROM Opportunity WHERE ID IN :ids];
	System.debug('opp ' + opp);
}