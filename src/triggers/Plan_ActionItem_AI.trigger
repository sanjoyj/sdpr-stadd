trigger Plan_ActionItem_AI on Action_Item__c (after insert, after update) {
	
		List<Id> lstActionItem = new List<Id>(); 
		if(Trigger.isInsert && Trigger.isAfter)
		{
			for(Action_Item__c AI:Trigger.New) 
			{	 
				lstActionItem.add(AI.id); 
			}
			ContributionLogHelper.CreateContributionFromActionItem(lstActionItem,'Action Item','Create'); 
			
		}
		if(Trigger.isUpdate)
		{
			for(Action_Item__c AI:Trigger.New) 
			{	 
				lstActionItem.add(AI.id); 
			}
			ContributionLogHelper.CreateContributionFromActionItem(lstActionItem,'Action Item','Edit');
			
		}

}