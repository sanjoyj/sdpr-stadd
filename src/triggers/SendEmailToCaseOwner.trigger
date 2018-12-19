/* Trigger Name : SendEmailToCaseOwner 
 * Description  : This trigger to send email to the owner of Case when a case alert is created.
 *                  
 * Created By   : Reju Palathingal
 * Created On   : 12-17-2013
 * 
*/

trigger SendEmailToCaseOwner on Case_Alert__c (after insert) {
    
    string theEmail;
    string theUser;
    Boolean result;
    String mystring;
    String casNum;

            for(Case_Alert__c alert: Trigger.New)
            {
                RecordType rectype = [Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Alert__c' limit 1];
                if(alert.RecordTypeId == rectype.Id)
                {
                    // Get the CaseID for this CaseAlert       
                    List<Case> casid = [select id,ownerid,owner.Email,CaseNumber from Case where id = :alert.Case__c LIMIT 1];
                    for(Case cas : casid)
                    {   
                        system.debug('caseId'+ cas.id );
                    
                        mystring = cas.OwnerId;
                        result= myString.contains('00G');
                        system.debug('result'+ result);
                       
                        theUser =  cas.ownerid;
                        casNum = cas.CaseNumber;
                        theEmail = cas.owner.Email;
                            //User usr = [select id,Email from User where id = :cas.ownerid LIMIT 1];
                         if((result != true) && (theEmail != null ))
                         {
                            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                            //system.debug('Id '+usr.id);
                          
                            message.setSaveAsActivity(false); 
                            //system.debug('email '+ usr.Email);
                            // String to hold the email addresses to which the email is being sent. 
                            message.setToAddresses (new String[] {theEmail});
                            
                            //message.setSenderDisplayName('Collaborate Program Admin');
                            //message.setReplyTo('stadd_program_admin@gov.bc.ca');
                            message.setSubject('A Restriced Alert has been posted to Case ' + casNum);
                            message.setPlainTextBody('Please log in to Collaborate and review this restricted alert.');
                    
                            // Send message under cover of org wide email address xreply@acme.com instead of user that executed trigger
                            // UAT: 0D2f00000008OXZ, Dev: 0D2f00000008OXe, Prod: 0D2i0000000GnJY
                            message.setOrgWideEmailAddressId('0D2i0000000GnJY');  // need to be updated based on the Org,                 
                      
                            // Send the email that has been created.  
                            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
                         }               
                    }
                }
            }
           
        }