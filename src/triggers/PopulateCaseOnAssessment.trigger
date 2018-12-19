trigger PopulateCaseOnAssessment on Assessment_List__c (after insert, before insert) {

    if(Trigger.isBefore)
    {
	    if(Trigger.isInsert)
	    {
	  PopulateCaseOnAssessmentHelper.manageInsertCase(trigger.new);
	    }   
        
    }
   
}