/* Trigger Name : SendEmailToCaseOwner 
 * Description  : This trigger to send email to the owner and the case team member of Case when a case alert is created.
 *                  
 * Created By   : Reju Palathingal
 * Created On   : 12-17-2013
 * 
*/

trigger NotifyCaseTeamOnCaseAlert on Case_Alert__c (after insert) {
    
    List<string> memEmail = new list<string>();
    
    string casNumcoll;
    Boolean result;
    String mystring;
    
    for(Case_Alert__c alert: Trigger.New)
    {
        RecordType rectype = [Select Id,Name From RecordType Where Name = 'Collaborative' and SobjectType ='Case_Alert__c' limit 1];
        // Get the CaseID, ownerid of the case related to the case alert 
        system.debug('Record type '+ rectype.Name) ;     
        if(alert.RecordTypeId == rectype.id)
        { 
            List<Case> casid = [select id,owner.Email, ownerid,CaseNumber from Case where id = :alert.Case__c limit 1];
            List<CaseTeamMember> casteam = [select id,memberId,member.Email from CaseTeamMember where parentId IN :casid];
            
            mystring = casid[0].OwnerId;
            casNumcoll = casid[0].CaseNumber;
            //system.debug('Owner'+mystring);
            result= myString.contains('00G');
            //system.debug('result' +result); 
                
            if(!casid.isempty() && (result != true))
            {                                   
                    memEmail.add(casid[0].owner.Email);                            
            }
            // all the case team members
            for(CaseTeamMember ctm : casteam)
            {   
                if(ctm.member.Email != null){
                memEmail.add(ctm.member.Email);  
                }                                           
            }
            if(memEmail.size()>0)
            {
                system.debug('Email ' +memEmail);
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();                       
                message.setSaveAsActivity(false);                       
                // String to hold the email addresses to which the email is being sent. 
                message.setBccAddresses (memEmail);
                // Send message under cover of org wide email instead of user that executed trigger
                // UAT: 0D2f00000008OXZ, Dev: 0D2f00000008OXe, Prod: 0D2i0000000GnJY
                message.setOrgWideEmailAddressId('0D2i0000000GnJY');  // need to be updated based on the Org,                 
                message.setSubject('An Alert has been posted to Case ' + casNumcoll);
                message.setPlainTextBody('Please log in to Collaborate and check this alert. If you have further questions, please contact your Navigator.');
                // Send the email that has been created.  
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
            }                           
         }       
    }
    
}