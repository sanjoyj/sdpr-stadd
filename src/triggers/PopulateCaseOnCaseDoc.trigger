trigger PopulateCaseOnCaseDoc on Case_Document__c (after insert, before insert) {
	
if(Trigger.isBefore)
    {
	    if(Trigger.isInsert)
	    {
	  PopulateCaseOnCaseDocHelper.manageInsertCase(trigger.new);
	    }   
        
    }

}