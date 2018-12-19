trigger Functional_Domail_Summary on Functional__c (after insert) {

	List<Id> lstFunctionalDomain = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Functional__c FDS:Trigger.New) 
		{	 
			lstFunctionalDomain.add(FDS.id); 
		}
		ContributionLogHelper.CreateContributionFromCaseFunctionalDomainSummaries(lstFunctionalDomain,'Functional Domain Summaries','Create'); 
		
	}
}