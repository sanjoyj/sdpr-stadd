/* Trigger Name : UniqueSupportPlan 
 * Description  : This trigger provides validation of having only one Support plan for specific case.
 * Created By   : Reju Palathingal
 * Created On   : 13-03-2013
*/

trigger UniqueSupportPlan on Plan__c (before insert, after update) {

 if((Trigger.isBefore && Trigger.isInsert) || (Trigger.isAfter && Trigger.isUpdate))
   {
        system.debug('inside if condition');
        Map<id,String> mapCaseCount = new Map<id,String>();
        set<ID> listCasesToUpdate = new set<ID>();
        set<ID> setCaseIds = new set<ID>();
        set<ID> setplanId = new set<ID>();
        for(Plan__c plan: trigger.new)
        {
            setCaseIds.add(plan.Case__c);
            system.debug(plan.Case__c);
        }    

         if(setCaseIds.size()>0) 
         { 
            for(Plan__c pln :[select id,Case__c,Plan_Type__c from Plan__c where Case__c IN:setCaseIds and Plan_Type__c = 'Support Plan' and ID NOT IN: Trigger.new]) 
            {       
            //if(mapCaseCount.containskey(pln.Case__c))
              //  {                   
                    mapCaseCount.put(pln.Case__c,pln.Plan_Type__c);
                    system.debug(pln.Case__c);                
               // }
                
            }
         }        
        for(Plan__c p: trigger.new)
        {
            if(p.Plan_Type__c == 'Support Plan') // if(C.IsClosed == true)
            {
                if(mapCaseCount.Containskey(p.Case__c))
                {               
                    p.adderror('You cannot have more than one Support Plan for an Individual', false);
                }   
            }
        }  
    }
}