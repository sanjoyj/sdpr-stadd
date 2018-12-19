trigger Protocols_Safeguards_AI on Protocols_and_Safeguards__c (after insert) {

	List<Id> lstProtocol = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Protocols_and_Safeguards__c PS:Trigger.New) 
		{	 
			lstProtocol.add(PS.id); 
		}
		ContributionLogHelper.CreateContributionFromProtocolsandsafeguards(lstProtocol,'Protocols and Safeguards','Create'); 
		
	}

}