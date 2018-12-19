/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Case Notes sharing
** Description: Sharing Case Notes records ,if the community user has access to Case or the Referral associated.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           2/5/2014         1.0                   Created** 

********************************************************************************************/

public without sharing class CaseNotesSharingController {


public List<Case_Note__c> casrecord{get; set;}
public List<UserRecordAccess> caids{get; set;}
public List<UserRecordAccess> refids{get; set;}
public Id id{get;set;}
public Boolean rend{get; set;}
public List<Id> lstcasid;
public List<Id> lstrefid;
public string caccess;
public string racccess;

	public CaseNotesSharingController(ApexPages.StandardController controller) 
	{
		id=  ApexPages.currentPage().getParameters().get('id');	
		casrecord = [select id,Referral__c,Case__c from Case_Note__c where id =: id limit 1];
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
}