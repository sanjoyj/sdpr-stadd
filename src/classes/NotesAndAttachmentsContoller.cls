/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Case Documents sharing
** Description: Sharing Case documents records ,if the community user has access to Case or the Referral associated.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           2/5/2014         1.0                   Created** 

********************************************************************************************/
public without sharing class NotesAndAttachmentsContoller {

public List<Case_Document__c> casrecord{get; set;}
public List<UserRecordAccess> caids{get; set;}
public List<UserRecordAccess> refids{get; set;}
public Id id{get;set;}
public Boolean rend{get; set;}
public List<Id> lstcasid;
public List<Id> lstrefid;
public string caccess;
public string racccess; 
public string DocId {get; set;}
public List<Profile> userprofile{get; set;}
public List<Attachment> att{get; set;}
public List<Case> Caselist{get; set;}
    
    public NotesAndAttachmentsContoller(ApexPages.StandardController controller) 
    {
        id=  ApexPages.currentPage().getParameters().get('id'); 
        casrecord = [select id,Referral__c,Case__c from Case_Document__c where id =: id limit 1];
        string cid= casrecord[0].Case__c;
        string rid= casrecord[0].Referral__c;   
        system.debug(cid);
        system.debug(rid);
        string userid = Userinfo.getUserId();
        
        List<User> usr = [Select Id, Username, UserType, ProfileId  FROM User where Id =: userid];
        string usrtype = usr[0].UserType;
        
        if(usrtype == 'PowerPartner')
            
        {
        
            //String strQuery = 'SELECT RecordId, HasEditAccess FROM UserRecordAccess WHERE UserId = \''+ string.escapeSingleQuotes(userid) + '\' AND ';
            if(cid != null || cid != '')
            {
                caids = [SELECT RecordId, HasAllAccess, HasEditAccess,MaxAccessLevel FROM UserRecordAccess WHERE UserId =: userid AND RecordId =:casrecord[0].Case__c];
                //strQuery = strQuery + ' (RecordID = \'' + string.escapeSingleQuotes(casid) + '\'';                
            }
            
            if(rid != null || rid != '')
            {
                refids = [SELECT RecordId, HasAllAccess,HasEditAccess,MaxAccessLevel FROM UserRecordAccess WHERE UserId =: userid AND RecordID =:casrecord[0].Referral__c];         

            }
            system.debug(caids);
            system.debug(refids);
            //system.debug(caids.size());
            //system.debug(refids[0].MaxAccessLevel);
            //List<UserRecordAccess> listUserAccessRecord = database.query(strQuery);
            if(!caids.isempty())
            {
                 caccess = caids[0].MaxAccessLevel;
            }
            
            if(!refids.isempty())
            {
                 racccess = refids[0].MaxAccessLevel;
            }
            system.debug(caccess);
            system.debug(racccess);
        
            if((caccess == 'NONE' || caccess == null) && (racccess == null || racccess == 'NONE' ))
            //if(listUserAccessRecord.Isempty()) 
            {
                //system.debug('Entered ELSE');
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Insufficient Privileges: You do not have access to this record.'));
                rend=false;
                
            }
            else 
            {
                //system.debug('Entered if');
                rend=true;
            }   
        }
        else
        {
            rend=true;
        }
    }
    
 public PageReference fnAuditUserDetails(){
    	
    try{
        
        if(DocId != null)
        {
         string sProfileName;
         string sProfileId;
         string sCaseDocId;
         string sCaseDocName;
         string sAttName;
         string sCaseNum;
         string sCaseId;
         System.debug('*******************DocId: ' + DocId);
        
         sProfileId = UserInfo.getProfileId();           
         if(sProfileId != null){
        	 userprofile = [Select Name from Profile where Id =:sProfileId limit 1];
         	if(!userprofile.isEmpty())
         		 sProfileName = userprofile[0].Name;
         }
                  
         sCaseDocId = Apexpages.currentPage().getParameters().get('Id');           
         if(sCaseDocId != null){
         	casrecord = [select Name, Case__c from Case_Document__c where id =: sCaseDocId limit 1];
         	if(!casrecord.isEmpty()){
         		sCaseDocName = casrecord[0].Name;
         		sCaseId = casrecord[0].Case__c;
         		if(sCaseId != null){
         		 Caselist = [select CaseNumber from Case where id =: sCaseId limit 1];
         		 	if(!Caselist.isEmpty())
         			 sCaseNum = Caselist[0].CaseNumber;
         		   }
         		}
           	}
         
		att = [select Name, ContentType from Attachment where id =:DocId limit 1];
		if(!att.isEmpty())
			sAttName = att[0].Name;

        File_Download_Audit__c  DFAObj = new File_Download_Audit__c();
        
        DFAObj.Case_Document_Name__c = sCaseDocName;
        DFAObj.Time_Date_of_Download__c = System.now();
        DFAObj.File_name__c = sAttName;
        DFAObj.Type__c= 'Attachment';
        DFAObj.User_Name__c = UserInfo.getFirstName() +' '+ UserInfo.getLastName();
        DFAObj.User_Profile__c = sProfileName;
        DFAObj.Case_Number__c = sCaseNum;
        
        insert DFAObj;
     }
    }
    catch (DMLException e)
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please contact the administrator'));
            return null;
        } 
        finally
        {
        	userprofile = null;
        	att = null;
        	Caselist = null;
        }
     return null;
    }
  }