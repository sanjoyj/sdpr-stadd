trigger Functional_Domain_Update_AI on Functional_Domain_Update__c (after insert) {
	
	List<Id> lstDomainUpdate = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Functional_Domain_Update__c CN:Trigger.New) 
		{	 
			lstDomainUpdate.add(CN.id); 
		}
		ContributionLogHelper.CreateContributionFromCaseFunctionalDomainUpdate(lstDomainUpdate,'Functional Domain Update','Create'); 
		
	}

}