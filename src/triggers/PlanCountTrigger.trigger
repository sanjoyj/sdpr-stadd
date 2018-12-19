/* Trigger Name : UpdatePlanAndGoal 
 * Description  : This trigger provide summary of Number of Plan__cs on Case record.
 * Created By   : Silviu Frantescu
 * Created On   : 10-17-2013
*/

trigger PlanCountTrigger on Plan__c (after delete, after insert, after undelete, after update) {
    list<Case> listCasesToUpdate = new list<case> ();    
    // get list of Cases
    set<ID> setCaseIds = new set<ID>();
    /*if(trigger.isUpdate){
        for(Plan__c plan: trigger.new){
            if(trigger.oldmap.get(plan.id).Case__c != trigger.newMap.get(plan.id).Case__c){
                setCaseIds.add(trigger.oldmap.get(plan.id).Case__c);
                setCaseIds.add(trigger.newmap.get(plan.id).Case__c);
            }
        }
    }*/
    if (Trigger.isDelete || trigger.isUpdate ){
        for(Plan__c plan: trigger.old){
            setCaseIds.add(plan.Case__c);
        }
    }       
    if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
        for(Plan__c plan: trigger.new){
            setCaseIds.add(plan.Case__c);
        }
    }
    system.debug('-----setCaseIds-------'+setCaseIds);
    
    if(setCaseIds.size()>0){
        for(Case cas : [select id, Number_of_Plans__c,(select id from Plans__r where Plan_Status__c ='Active Plan' and Plan_Type__c = 'Crisis Plan') from case where id in :setCaseIds]){
            listCasestoUpdate.add(new case(id=cas.id, Number_of_Plans__c = cas.Plans__r.size()));
        }
    }
    if(listCasestoUpdate.size()>0){
        try{
            update listCasestoUpdate;
        }
        catch(Exception ex){
            system.debug('----------'+ex);
        }
    }
}