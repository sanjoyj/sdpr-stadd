trigger Support_Service_AI on Support_and_Service__c (after insert) {

	List<Id> lstService = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Support_and_Service__c SS:Trigger.New) 
		{	 
			lstService.add(SS.id); 
		}
		ContributionLogHelper.CreateContributionFromSupportandservice(lstService,'Supports and Services','Create'); 
		
	}
}