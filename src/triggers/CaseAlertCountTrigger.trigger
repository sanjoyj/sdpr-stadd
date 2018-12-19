/* Trigger Name : CaseAlertCountTrigger 
 * Description  : This trigger provide summary of alerts on Case record.
 * Created By   : Silviu Frantescu
 * Created On   : 10-17-2013
*/

trigger CaseAlertCountTrigger on Case_Alert__c  (after delete, after insert, after undelete, after update) {
    list<Case> listCasesToUpdate = new list<case> ();    
    // get list of Cases
    set<ID> setCaseIds = new set<ID>();
    /*if(trigger.isUpdate){
    	for(Case_Alert__c alert: trigger.new){
    		if(trigger.oldmap.get(alert.id).Case__c != trigger.newMap.get(alert.id).Case__c){
    			setCaseIds.add(trigger.oldmap.get(alert.id).Case__c);
    			setCaseIds.add(trigger.newmap.get(alert.id).Case__c);
    		}
    	}
    }*/
    
    if (Trigger.isDelete || trigger.isUpdate ){
        for(Case_Alert__c alert: trigger.old){
            setCaseIds.add(alert.Case__c);
        }
    }       
    if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
        for(Case_Alert__c alert: trigger.new){
            setCaseIds.add(alert.Case__c);
        }
    }
    system.debug('-----setCaseIds-------'+setCaseIds);
    
    if(setCaseIds.size()>0){
        for(Case cas : [select id, Number_of_Case_Alerts__c,(select id, RecordType.Name from Case_Alerts1__r where Status__c = 'Open') from case where id in :setCaseIds]){
            integer intPortalAlertCount = 0;
            for(Case_Alert__c portalAlert : cas.Case_Alerts1__r){
            	if(portalAlert.RecordType.Name == 'Collaborative'){
            		intPortalAlertCount++;
            	}
            }
            listCasestoUpdate.add(new case(id=cas.id, Number_of_Case_Alerts__c= cas.Case_Alerts1__r.size(), Number_of_Alerts_for_Portal__c = intPortalAlertCount));
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