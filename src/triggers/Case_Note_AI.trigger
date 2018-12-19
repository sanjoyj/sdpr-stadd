trigger Case_Note_AI on Case_Note__c (after insert) {

	List<Id> lstCase = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Case_Note__c CN:Trigger.New) 
		{	 
			lstCase.add(CN.id); 
		}
		ContributionLogHelper.CreateContributionFromNote(lstCase,'Case Note','Create');
		
	}
}