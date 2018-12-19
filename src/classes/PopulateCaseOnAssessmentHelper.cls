/* @Trigger Name : PopulateCaseOnAssessmentHelper 
 * @Description  : This class is a helper class for the Assessment trigger
 * @Created By   : Reju Palathingal 
 * @Created On   : 10/03/2013
 * @Modification Log:  
 * -----------------------------------------------------------------------------
 * @Developer                Date                  Description 
 * -----------------------------------------------------------------------------
 * @Reju Palathingal         10/03/2013                Created
 * 
 * -----------------------------------------------------------------------------
 */

public with sharing class PopulateCaseOnAssessmentHelper {


Public static Set<id>parentIds = new Set<id>();

public static void manageInsertCase(List<Assessment_List__c> newTriggerList)
		
	{
	
	    for(Assessment_List__c ast :newTriggerList)
	    {
	        parentIds.add(ast.Functional_Domain__c);
	    }
	    Map<id,Functional__c> pro = new Map<id,Functional__c>([select id, Case__c from Functional__c where id in :parentIds]);
	    system.debug('Map' +pro);
	    for(Assessment_List__c astlst :newTriggerList)
	    {
	        
	            if(pro.containsKey(astlst.Functional_Domain__c))
	            	
	            {
	                        
	                astlst.Case__c = pro.get(astlst.Functional_Domain__c).Case__c;
	            }   
	    }           
	}
}