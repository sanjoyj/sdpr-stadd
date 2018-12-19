trigger Case_Documents_AI on Case_Document__c (after insert) {

	List<Id> lstCaseDocument = new List<Id>();
	if(Trigger.isInsert && Trigger.isAfter)
	{
		for(Case_Document__c CD:Trigger.New) 
		{	 
			lstCaseDocument.add(CD.id);
		}
		ContributionLogHelper.CreateContributionFromCaseDocuments(lstCaseDocument,'Case Document','Create'); 
		
	}
}