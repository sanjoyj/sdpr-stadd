trigger List_Of_Assessments on Assessment_List__c (after insert) {
	
	List<Id> lstAssessments = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Assessment_List__c LA:Trigger.New) 
		{	 
			lstAssessments.add(LA.id); 
		}
		ContributionLogHelper.CreateContributionFromAssessments(lstAssessments,'List of Assessments','Create'); 
		
	}

}