/* Trigger Name : UpdatePlanAndGoal 
 * Description  : This trigger updates the goal and plan that the action item belongs to depending upon the respective milestone.
 * Created By   : Silviu Frantescu
 * Created On   : 10-17-2013
*/

trigger UpdatePlanAndGoal on Action_Item__c (before insert) {
    set<id> setMilestoneIds = new set<id> ();
    for(Action_Item__c  actItem : trigger.new){
        setMilestoneIds.add(actItem.Milestone__c);
    }
    /*if(trigger.isUpdate){
        for(Action_Item__c actItem : trigger.new){
            if(trigger.oldMap.get(actItem.id).Milestone__c != trigger.newMap.get(actItem.id).Milestone__c)
                setMilestoneIds.add(actItem.Milestone__c);
        }
    }*/
    
    map<id, Plan_Milestone__c> mapMileStone = new map<id, Plan_Milestone__c> ([select id, Plan_Goal__c, Plan_Goal__r.Plan__c from Plan_Milestone__c where id IN :setMilestoneIds]);
    if(mapMileStone != null && mapMileStone.keyset().size()>0){
        for(Action_Item__c  actItem : trigger.new){
            actItem.Plan_Goal__c  = mapMileStone.get(actItem.Milestone__c).Plan_Goal__c;
            actItem.Plan__c = mapMileStone.get(actItem.Milestone__c).Plan_Goal__r.Plan__c;
        }
    }    
}