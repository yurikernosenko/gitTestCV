trigger OpportunityTrigger on Opportunity (after update) {
	System.debug('OpportunityTrigger after update ' + Trigger.new);
}