trigger Plan_Goal_AI on Plan_Goal__c (after insert, after update) {

	List<Id> lstGoal = new List<Id>(); 
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Plan_Goal__c PG:Trigger.New) 
		{	 
			lstGoal.add(PG.id); 
		}
		ContributionLogHelper.CreateContributionFromGoal(lstGoal,'Goals','Create'); 
		
	}
	if(Trigger.isUpdate)
	{
		for(Plan_Goal__c PG:Trigger.New) 
		{	 
			lstGoal.add(PG.id); 
		}
		ContributionLogHelper.CreateContributionFromGoal(lstGoal,'Goals','Edit');
		
	}

}