trigger Case_Alert_AI on Case_Alert__c (after insert) {
	
	List<Id> lstCaseAlert = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Case_Alert__c CA:Trigger.New) 
		{	 
			lstCaseAlert.add(CA.id); 
		}
		ContributionLogHelper.CreateContributionFromCaseAlert(lstCaseAlert,'Case Alert','Create'); 
		
	}

}