/* Trigger Name : CaseCloseTrigger 
 * Description  : This trigger restrict closing of a case when there is a open Case 
 *                  alert/Plan/Goal/Milestone/ActionItem.
 * Created By   : Gaurav Verma
 * Created On   : 10-25-2013
 * @Reju        :changes done for the Defect D-00214 
*/
trigger CaseCloseTrigger on Case (before update) {
    if(!ProcessorControl.inContext){
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        //////All Case Alerts not in status of "Resolved"
        Map<id,boolean> mapCaseAlertCount = new Map<id,boolean>();
        string strAlertName = '';
        
        string strPlanName ='';
        string strGoalName ='';
        string strMilestoneName ='';
        string strActionItmName ='';
        string strtoresolve='';
        boolean alertmsg= false;
        
        List<Case_Alert__c> alertpart = new List<Case_Alert__c>() ;
        for(Case_Alert__c CA: [select id, Name, Status__c, Case__c from Case_Alert__c 
                                                        where Case__c IN : Trigger.newMap.keySet()
                                                        and Status__c != 'Resolved'
                                                        and Status__c != 'Closed'])
        {
                if(!mapCaseAlertCount.containskey(CA.case__c))
                {                   
                    mapCaseAlertCount.put(CA.case__c,true);
                
                }
            
                strAlertName = strAlertName + CA.Name + ', ' ;
                //strAlertName= strAlertName.subString(0,strAlertName.Length()-2);
                //strAlertName = strAlertName.removeEnd(',');   
        }
        
        
        //////All Plan not in status of "Completed" OR "No Longer Required"
        Map<id,boolean> mapCasePlanCount = new Map<id,boolean>();
        
        for(Plan__c P: [select id, Name, Plan_Status__c, Case__c from Plan__c 
                                                        where Case__c IN : Trigger.newMap.keySet()
                                                        and Plan_Status__c != 'Not Current'
                                                        and Plan_Status__c != 'Closed' 
                                                        and Plan_Status__c != 'Not Active'])
        {
                if(!mapCasePlanCount.containskey(P.case__c))
                {                   
                    mapCasePlanCount.put(P.case__c,true);
                }
                strPlanName = strPlanName + P.Name + ', ' ;
                strPlanName = strPlanName.removeEnd(',');
        }
        //////All Goals not in status of "Completed" OR "No Longer Required"
        Map<id,boolean> mapGoalCount = new Map<id,boolean>();
        for(Plan_Goal__c G: [select id,Name, Status__c, Plan__r.Case__c from Plan_Goal__c 
                                                        where Plan__r.Case__c IN : Trigger.newMap.keySet()
                                                        and Status__c != 'Completed' 
                                                        and Status__c != 'Closed' 
                                                        and Status__c != 'No Longer Required'])
        {
                if(!mapGoalCount.containskey(G.Plan__r.case__c))
                {                   
                    mapGoalCount.put(G.Plan__r.case__c,true);
                }
                strGoalName = strGoalName + G.Name + ', ' ;
                strGoalName = strGoalName.removeEnd(','); 
        }       
        //////All Milestone not in status of "Completed" OR "No Longer Required"
        Map<id,boolean> mapMilestoneCount = new Map<id,boolean>();
        for(Plan_Milestone__c M: [select id, Name, Status__c,Plan_Goal__r.Plan__r.Case__c from Plan_Milestone__c 
                                                        where Plan_Goal__r.Plan__r.Case__c=: Trigger.newMap.keySet() 
                                                        and Status__c != 'Completed' 
                                                        and Status__c != 'Closed'
                                                        And Status__c != 'No Longer Required'])
        {
                if(!mapMilestoneCount.containskey(M.Plan_Goal__r.Plan__r.Case__c))
                {                   
                    mapMilestoneCount.put(M.Plan_Goal__r.Plan__r.Case__c,true);
                }
                strMilestoneName = strMilestoneName + M.Name + ', ' ;
                strMilestoneName = strMilestoneName.removeEnd(','); 
        }       
        //////All Action Items not in status of "Completed" OR "No Longer Required"
        Map<id,boolean> mapActionItemCount = new Map<id,boolean>();
        for(Action_Item__c A: [select id, Name, Status__c,Milestone__r.Plan_Goal__r.Plan__r.Case__c from Action_Item__c 
                                                        where Milestone__r.Plan_Goal__r.Plan__r.Case__c=: Trigger.newMap.keySet() 
                                                        and Status__c != 'Complete' 
                                                        and Status__c != 'Closed'
                                                        And Status__c != 'No Longer Required'
                                                        And Status__c != 'Owner Change'])
        {
                if(!mapActionItemCount.containskey(A.Milestone__r.Plan_Goal__r.Plan__r.Case__c))
                {                   
                    mapActionItemCount.put(A.Milestone__r.Plan_Goal__r.Plan__r.Case__c,true);
                }
                strActionItmName = strActionItmName + A.Name + ', ' ;
                strActionItmName = strActionItmName.removeEnd(','); 
        }       
        //////All Case Team Members still on the Case
        Map<id,boolean> mapCaseTeamMemberCount = new Map<id,boolean>();
        for(CaseTeamMember T: [select MemberId, ParentId from CaseTeamMember 
                                                        where ParentId=: Trigger.newMap.keySet() ])
        {
                if(!mapCaseTeamMemberCount.containskey(T.ParentId))
                {                   
                    mapCaseTeamMemberCount.put(T.ParentId,true);
                }
        }    

        for (Case C : trigger.new)
        {
            if(C.Status == 'Closed' && C.Case_Closed_Reason__c == 'No Contact - Inactive')
            {
                List <Action_Item__c> ListAI = [select id, Status__c from Action_Item__c where Milestone__r.Plan_Goal__r.Plan__r.Case__c=:C.Id and Status__c !='Complete' and Status__c !='No Longer Required' and Status__c != 'Owner Change'];
                for (Action_Item__c ai : ListAI){
                    ai.Status__c = 'Closed';
                }
                update ListAI;
                
                List <Plan_Milestone__c> ListPM = [select id, Status__c from Plan_Milestone__c where Plan_Goal__r.Plan__r.Case__c=:C.Id and Status__c != 'Completed' And Status__c != 'No Longer Required'];
                for (Plan_Milestone__c pm : ListPM){
                    pm.Status__c = 'Closed';
                }
                update ListPM;
                
                List <Plan_Goal__c> ListPG = [select id, Status__c from Plan_Goal__c where Plan__r.Case__c=:C.Id and Status__c != 'Completed' and Status__c != 'No Longer Required'];
                for (Plan_Goal__c pg : ListPG){
                    pg.Status__c = 'Closed';
                }
                update ListPG;
                
                List <Plan__c> ListP = [select id, Plan_Status__c from Plan__c where Case__c=:C.Id and Plan_Status__c != 'Not Current' and Plan_Status__c != 'Not Active'];
                for (Plan__c plan : ListP){
                    plan.Plan_Status__c = 'Closed';
                }
                update ListP;
                
                List <Case_Alert__c> ListCA = [select id, Status__c from Case_Alert__c where Case__c=:C.Id and Status__c != 'Resolved'];
                for (Case_Alert__c ca : ListCA){
                    ca.Status__c = 'Closed';
                }
                update ListCA;
                if(mapCaseTeamMemberCount.Containskey(c.id))
                {
                    //c.adderror('Please ensure the Members are deleted before closing the Case:'+' '+strCaseTeamName);
                    strtoresolve =strtoresolve +'<br/>'+ 'Remove the case team member(s) on this case';
                    alertmsg= true;
                }
                    
            }
            else if(C.Status == 'Closed') // if(C.IsClosed == true)
            {
                if(mapCaseAlertCount.Containskey(c.id))
                {
                    //c.adderror('Please resolve all the following Case Alerts before closing the Case :'+' '+  strAlertName );
                    strtoresolve = 'Case Alerts:  '+ strAlertName ;
                    alertmsg= true;
                    
                }
                if(mapCasePlanCount.Containskey(c.id))
                {
                    //c.adderror('Please resolve all the following Plans before closing the Case :'+ ' '+strPlanName );
                    strtoresolve = strtoresolve +'<br/>' +'Plans:  '+ strPlanName;
                    alertmsg= true;
                }
                if(mapGoalCount.Containskey(c.id))
                {
                    //c.adderror('Please Resolve all Case Goels before closing the Case:'+' '+strGoalName);
                    strtoresolve =strtoresolve +'<br/>'+ 'Plan Goals:  '+ strGoalName;
                    alertmsg= true;
                }
                if(mapMilestoneCount.Containskey(c.id))
                {
                    //c.adderror('Please Resolve all Milestones before closing the Case:'+ ' '+strMilestoneName);
                    strtoresolve =strtoresolve +'<br/>'+'Plan Milestones:  '+  strMilestoneName;
                    alertmsg= true;
                }
                if(mapActionItemCount.Containskey(c.id))
                {
                    //c.adderror('Please resolve all the following Action Items before closing the Case:'+' '+strActionItmName);
                    strtoresolve =strtoresolve +'<br/>'+ 'Action Items:  '+  strActionItmName;
                    alertmsg= true;
                }
                if(mapCaseTeamMemberCount.Containskey(c.id))
                {
                    //c.adderror('Please ensure the Members are deleted before closing the Case:'+' '+strCaseTeamName);
                    strtoresolve =strtoresolve +'<br/>'+ 'Remove the case team member(s) on this case';
                    alertmsg= true;
                }                
            }
          if(alertmsg == true)
                {
                    strtoresolve =strtoresolve.removeEnd(',');
                    c.adderror('Please resolve all the following before closing the case:'+' '+strtoresolve, false);
                }
        }
    }
  }     
}