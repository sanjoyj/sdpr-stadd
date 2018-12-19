/* TriggerName : SetActionItemAssignedTo 
 * Description  : This trigger set the Assigned to the looged in user and uncheck the ActionItem to me Flag whenever the record is saved.
 * Created By   : Reju Palathingal
 * Created On   : 12-6-2013
*/


trigger SetActionItemAssignedTo on Action_Item__c (before insert, before update) {

   // set<id> setMilestoneIds = new set<id> ();
    for(Action_Item__c  actItem : trigger.new){
         if(actItem.Assign_To_Me__c == true){
                actItem.Assigned_To__c = Userinfo.getUserId();
                actItem.Assign_To_Me__c = false;
            }
    }
    
}