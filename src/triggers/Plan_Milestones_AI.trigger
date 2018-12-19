trigger Plan_Milestones_AI on Plan_Milestone__c (after insert, after update) {
	List<Id> lstMilestone = new List<Id>(); 
		if(Trigger.isInsert && Trigger.isAfter)
		{
			for(Plan_Milestone__c PG:Trigger.New) 
			{	 
				lstMilestone.add(PG.id); 
			}
			ContributionLogHelper.CreateContributionFromMilestone(lstMilestone,'Milestone','Create'); 
			
		}
		if(Trigger.isUpdate)
		{
			for(Plan_Milestone__c PG:Trigger.New) 
			{	 
				lstMilestone.add(PG.id); 
			}
			ContributionLogHelper.CreateContributionFromMilestone(lstMilestone,'Milestone','Edit');
			
		}
}