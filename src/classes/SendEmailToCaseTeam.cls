/******************************************************************************************
** ICM STADD Project Enhancements
*******************************************************************************************
** Class Name: Send Email to Case Team
** Description: Sending Email to Case Team members given a Case ID
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**sanjoy Joseph          1/13/2016         1.0                   Created** 
**sanjoy Joseph			 1/12/2018		   2.0	                 Updated to change Email verbiage

********************************************************************************************/
global without sharing class SendEmailToCaseTeam {
     
     webservice static void SendEmail(Id caseId, Id childId){

         //Get the caseTeamMembers
         Map<Id, Map<Id, CaseTeamMember>> caseTeamMembers = getCaseToTeamMemberMap(caseId);
         System.Debug('caseTeamMembers'+caseTeamMembers);
         
         //Get the MemberId aka. userId from the caseTeamMembers
         Set<Id> caseTeamMemberUserIds = getCaseTeamMemberEmail(caseTeamMembers);
         System.Debug('caseTeamMemberUserIds'+caseTeamMemberUserIds);
         
        //Create a userMap
        Map<Id, User> usersMap  = getUsers(caseTeamMemberUserIds);
        System.Debug('usersMap'+usersMap);
        
        //Create a list of emailAddresses
        List<String> usersEmailList = getUserEmailList(usersMap, caseTeamMemberUserIds);
        System.Debug('usersEmailList'+usersEmailList);
        
        Case currentCase = [select     Id,
                                    Description,
                                    CaseNumber,
                                    Subject
                                    from Case
                                    where Id =: caseId ];
         //Finally sendEmail
         if (usersEmailList.isEmpty())
         {    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'The case does not have a case team.No notifications will be send');
              ApexPages.addMessage(myMsg);
         }
         else
         SendEmail(usersEmailList,'',currentCase,childId);  
     }
    
    private static Map<Id, Map<Id, CaseTeamMember>> getCaseToTeamMemberMap( Id caseId ) {
        List<CaseTeamMember> members = [
            SELECT Id, ParentId, MemberId, TeamRoleId
            FROM CaseTeamMember
            WHERE ParentId =:caseId
        ];
        
        Map<Id, Map<Id, CaseTeamMember>> caseToTeamMembers = new Map<Id, Map<Id, CaseTeamMember>>();
        for( CaseTeamMember mem : members ) {
            Map<Id, CaseTeamMember> memberMap = caseToTeamMembers.get( mem.ParentId );
            if( memberMap == null ) {
                memberMap = new Map<Id, CaseTeamMember>();
                caseToTeamMembers.put( mem.ParentId, memberMap );
            }
            memberMap.put( mem.MemberId, mem );
        }
        System.debug( caseToTeamMembers );
        return caseToTeamMembers;
    }    
    
    private static Set<Id> getCaseTeamMemberEmail(Map<Id, Map<Id, CaseTeamMember>> caseToTeamMeners){
        Set<Id> usersId = new Set<Id>();
        if(caseToTeamMeners != null){
            for(Id caseId : caseToTeamMeners.keyset()){
                Map<Id, CaseTeamMember> caseTeamMember = caseToTeamMeners.get(caseId);
                for(Id memberId : caseTeamMember.keyset()){
                    usersId.add(memberId);
                }
            }
        }
        return usersId;
    }
    
    private static Map<Id, User> getUsers(Set<Id> usersId){
        return new Map<Id,User>([select Id,
                                        Email 
                                        from User 
                                        where ID IN: usersId ]);
    }
    
    private static List<String> getUserEmailList(Map<Id,User> usersMap ,Set<Id> userIds){
        List<String> userEmailList = new List<String>();
        
        if(userIds !=null && userIds !=null){
         for(Id uId : userIds){
           if(usersMap.get(uId) != null)
                   userEmailList.add(usersMap.get(uId).Email);
              }
        }
        return UserEmailList;
     }
       
     private static void SendEmail(List<String> toAddresses, string replyTo, Case CurrentCase,Id childId){
   
         String sObjName = childId.getSObjectType().getDescribe().getLabel(); 
         String childLink ='';
         String action = '';
         DateTime d = Datetime.Now() ;
         ID userid;
         String childName='';
         String CaseLink =System.URL.getSalesforceBaseUrl().toExternalForm().remove('-api' )+'/'+CurrentCase.Id; 
        If (sObjName=='Support and Service')
        {   Support_and_Service__c child1 = [select Id,LastModifiedDate,LastModifiedById,CreatedDate,
                                            Name
                                            from Support_and_Service__c
                                            where Id =: childId ];   
         childLink =System.URL.getSalesforceBaseUrl().toExternalForm().remove('-api' )+'/'+child1.Id;
         childName=child1.Name;
         d = child1.LastModifiedDate;
         userid=child1.LastModifiedById;
         if (child1.LastModifiedDate == child1.CreatedDate)
         {
             action='created';
         }
         else
         {
             action='updated';
         }
        }
        else if (sObjName=='Plan Goal')
        {   Plan_Goal__c child2 = [select Id,LastModifiedDate,LastModifiedById,CreatedDate,
                                            Name
                                            from Plan_Goal__c
                                            where Id =: childId ]; 
         childLink =System.URL.getSalesforceBaseUrl().toExternalForm().remove('-api' )+'/'+child2.Id;
         childName=child2.Name;
         d = child2.LastModifiedDate;
         userid=child2.LastModifiedById;
         if (child2.LastModifiedDate == child2.CreatedDate)
         {
             action='created';
         }
         else
         {
             action='updated';
         }
        }
            else
        {   Plan_Milestone__c child3 =[select Id,LastModifiedDate,LastModifiedById,CreatedDate,
                                            Name
                                            from Plan_Milestone__c
                                            where Id =: childId ]; 
          childLink =System.URL.getSalesforceBaseUrl().toExternalForm().remove('-api' )+'/'+child3.Id;
          childName=child3.Name;
          d = child3.LastModifiedDate;
          userid=child3.LastModifiedById;
         if (child3.LastModifiedDate == child3.CreatedDate)
         {
             action='created';
         }
         else
         {
             action='updated';
         }
         
        }
          STADDLink__c link = STADDLink__c.getInstance();  
          User lastmodifieduser= [Select Name,TimeZoneSidKey from User where id =: userid];   
          TimeZone tz = TimeZone.getTimeZone(lastmodifieduser.TimeZoneSidKey);
          String dateStr =  d.format('dd MMMMM yyyy hh:mm a ') + tz.getDisplayName();
          //String TXTEmailBody = '<a href=STADDLink__c.getInstance() target="_blank"><h4>Please click here to update Enquiry</h4></a>';
          /*string TXTEmailBody =lastmodifieduser.Name +' added new information to '+sObjName+' - '+childName+' related to Case'+' '+CurrentCase.CaseNumber+' on '+dateStr + '.'+
              +'\n\nPlease click on Link '+link.STADDLinkURL__c +' to log into Collaborate. '+
             // +'\n\n Child Link: '+childLink
              +'\n\nThank You! \n' + 'STADD Admin';
          */
          /*string TXTEmailBody ='A change has been made in '+sObjName
              +'\n -Case: '+CurrentCase.CaseNumber+
              +'\n -Action: '+action+ 
              +'\n -Date & Time: '+dateStr+
              +'\n\nPlease click on Link '+link.STADDLinkURL__c +' to log into Collaborate. If you are no longer on this case team, please notify the STADD navigator.' 
              +'\n\nThank You! \n' + 'STADD Admin';
         */
          string TXTEmailBody ='A '+ sObjName + ' has been ' + action +' on Case: '+CurrentCase.CaseNumber +'\n\n'+
              +'Date & Time: '+dateStr+
              +'\n\nPlease click the link below to log in to Collaborate:' 
              +'\n'+childlink+
              +'\n\nIf you are no longer on this case team, please notify the STADD Navigator.'+
              +'\n\nThank you, \n' + 'STADD Administrator';
          string Subject ='A '+sObjName +' has been '+ action +' in Collaborate';
          // Send Email
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          mail.setToAddresses(toAddresses);
          //mail.setReplyTo(replyTo);
          OrgWideEmailAddress owa = [select id, Address, DisplayName from OrgWideEmailAddress limit 1];
          mail.setOrgWideEmailAddressId(owa.id);
          mail.setCharset('UTF-8');
          mail.setSubject(Subject);
          mail.setUseSignature(false);
          mail.setPlainTextBody(TXTEmailBody);
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });   
     
     }
}