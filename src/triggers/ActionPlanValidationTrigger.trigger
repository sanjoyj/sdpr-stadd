trigger ActionPlanValidationTrigger on Action_Item__c (before insert, before update) {

    string sCaseId;
    string sAssignToOwner;
    boolean sAssignToMeflag;
    string sUserId;
    string sCreatedbyId;
    boolean sValidationFlag;
    string sCaseOwner;
    string sUserProfileId;
    string sProfileName;
    public List<Case> obcase{get; set;}
    public List<Profile> userPrf{get; set;}

    if(Trigger.isBefore && Trigger.isUpdate)
    {
        for(Action_Item__c  actItem : trigger.new){
            sCaseId = actItem.Case_ID__c;
            sAssignToMeflag = actItem.Assign_To_Me__c;
            sAssignToOwner = actItem.Assigned_To__c;
            sCreatedbyId = actItem.CreatedById;
            sUserId = UserInfo.getUserId();
            sUserProfileId = UserInfo.getProfileId();
            
            system.debug('****************sCaseId :'+ sCaseId +'; sAssignToMeflag :'+ sAssignToMeflag+'; sAssignToOwner :'
            + sAssignToOwner+'; sUserId :' + sUserId + '; sCreatedbyId : '+ sCreatedbyId); 

                if(sUserProfileId != null){
                     if(sUserProfileId != null){
                         userPrf = [Select Name from Profile where Id =:sUserProfileId limit 1];
                         if(!userPrf.isEmpty())
                             sProfileName = userPrf[0].Name;
                    }
                }
                
                
                if(sCaseId != null){
                    obcase = [Select OwnerId from Case where Id =:sCaseId limit 1];
                if(!obcase.isEmpty()){
                    sCaseOwner= obcase[0].OwnerId;
                    system.debug('****************sCaseOwner :'+ sCaseOwner);     
                }
            }
            
            if((sProfileName != null && sProfileName != 'System Administrator' && sProfileName != 'STADD Director' && sProfileName != 'STADD Project Administrator' && sProfileName != 'STADD Coordinator') && sCaseOwner != sUserId)
                {
                    if(sAssignToOwner == null) 
                    {
                         if(!sAssignToMeflag) 
                         {
                            if((sUserId != sAssignToOwner) && (sUserId != sCreatedbyId))
                            {
                            actItem.adderror('You cannot edit Action Items that you did not create, or are not assigned to you');
                            system.debug('****************sAssignToOwner :'+ sAssignToOwner +'; sValidationFlag :'+ sValidationFlag +'; sCaseOwner :'+sCaseOwner);
                            }   
                         }
                    }
                    else if(((sUserId != sAssignToOwner) && (sUserId != sCreatedbyId) || ((sCaseOwner != sUserId) && (sUserId != sAssignToOwner) && (sUserId != sCreatedbyId) )))
                    {
                            if(sAssignToOwner != null)  
                                actItem.adderror('Please assign the Action Item to yourself if you wish to edit the record');
                            //else
                            //  actItem.adderror('record update is allowed');
                    }               
                }
            if(actItem.Assign_To_Me__c == true){
                            actItem.Assigned_To__c = Userinfo.getUserId();
                            actItem.Assign_To_Me__c = false;
                        }
          }//for
    }//Isupdated
    if(Trigger.isBefore && Trigger.isInsert)// Reshma modified to update the Assign to me flag logic for the 4.1.2 Enhancements
    {
        // set<id> setMilestoneIds = new set<id> ();
               for(Action_Item__c  actItem : trigger.new){
                 if(actItem.Assign_To_Me__c == true && actItem.Assigned_To__c == null ){
                 actItem.Assigned_To__c = Userinfo.getUserId();
                 actItem.Assign_To_Me__c = false;}
                 else 
                 {actItem.Assign_To_Me__c = false;} 
              
        } //for
    } //trigger if
}//trigger