/* Trigger Name : ProtocolCountTrigger 
 * Description  : This trigger provide summary of Protocols on Case record.
 * Created By   : Silviu Frantescu
 * Created On   : 10-17-2013
*/

trigger ProtocolCountTrigger on Protocols_and_Safeguards__c (after delete, after insert, after undelete, after update) {
    list<Case> listCasesToUpdate = new list<case> ();    
    // get list of Cases
    set<ID> setCaseIds = new set<ID>();
    /*if(trigger.isUpdate){
    	for(Protocols_and_Safeguards__c protocol: trigger.new){
    		if(trigger.oldmap.get(protocol.id).Case__c != trigger.newMap.get(protocol.id).Case__c){
    			setCaseIds.add(trigger.oldmap.get(protocol.id).Case__c);
    			setCaseIds.add(trigger.newmap.get(protocol.id).Case__c);
    		}
    	}
    }*/
    if (Trigger.isDelete || trigger.isUpdate ){
        for(Protocols_and_Safeguards__c protocol: trigger.old){
            setCaseIds.add(protocol.Case__c);
        }
    }       
    if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
        for(Protocols_and_Safeguards__c protocol: trigger.new){
            setCaseIds.add(protocol.Case__c);
        }
    }
    system.debug('-----setCaseIds-------'+setCaseIds);
    
    if(setCaseIds.size()>0){
        for(Case cas : [select id, Number_of_Protocals__c,(select id from Protocols_and_Safeguards__r where Active__c = true) from case where id in :setCaseIds]){
            listCasestoUpdate.add(new case(id=cas.id, Number_of_Protocals__c = cas.Protocols_and_Safeguards__r.size()));
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