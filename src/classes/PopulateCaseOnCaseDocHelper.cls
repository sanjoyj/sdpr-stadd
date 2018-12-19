/* @Trigger Name : PopulateCaseOnCaseDocHelper 
 * @Description  : This class is a helper class for the Case Document trigger
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
public with sharing class PopulateCaseOnCaseDocHelper {
	
	public static Set<id>parentIds = new Set<id>();
	public static void manageInsertCase(List<Case_Document__c> newTriggerList)
	{
	
	    for(Case_Document__c ast :newTriggerList)
	    {
	        parentIds.add(ast.Protocols_and_Safeguards__c);
	    }
	    Map<id,Protocols_and_Safeguards__c> pro = new Map<id,Protocols_and_Safeguards__c>([select id, Case__c from Protocols_and_Safeguards__c where id in :parentIds]);
	    
	    for(Case_Document__c astlst :newTriggerList)
	    {
	        
	        	if(pro.containsKey(astlst.Protocols_and_Safeguards__c))
	        	{
	        		      	
	           		astlst.Case__c = pro.get(astlst.Protocols_and_Safeguards__c).Case__c;
	        	}	
	        
	    }
	    
	}
}