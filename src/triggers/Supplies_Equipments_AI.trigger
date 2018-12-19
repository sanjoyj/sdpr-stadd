trigger Supplies_Equipments_AI on Supplies_and_Equipment__c (after insert) {

	List<Id> lstSupplies = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Supplies_and_Equipment__c SE:Trigger.New) 
		{	 
			lstSupplies.add(SE.id); 
		}
		ContributionLogHelper.CreateContributionFromSuppliesandEquipments(lstSupplies,'Supplies and Equipment','Create'); 
		
	}
}