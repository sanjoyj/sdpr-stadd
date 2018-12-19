/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Sharing the contact records
** Description: Sharing contact records which are not of partner type.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           1/28/2013         1.0                   Created** 

********************************************************************************************/
public without sharing class ContactSharingForComm {

public Id id{get;set;}
public List<Contact> conrecord {get; set;}
public List<Account> accrecord {get; set;}
public Boolean rend{get; set;}
public boolean ispartner{get; set;}
public string accid{get; set;}
public string usrtype{get; set;}
public string accname{get; set;}

	public ContactSharingForComm(ApexPages.StandardController controller){
		id=  ApexPages.currentPage().getParameters().get('id');
		Contact con = new Contact();
        string userid = Userinfo.getUserId();
        
        conrecord = [select id,AccountId from Contact where id =: id limit 1];
        if(!conrecord.isempty()){
			accid = conrecord[0].AccountId;
        }
        accrecord = [select id,IsPartner,Name from Account where id =: accid limit 1];
        if(!accrecord.isempty())
        {
        	ispartner = accrecord[0].IsPartner;
        	accname =accrecord[0].Name;
		}
		List<User> usr = [Select Id, Username, UserType, ProfileId  FROM User where Id =: userid];
		if(!usr.isempty())
		{
			usrtype = usr[0].UserType;
		}
		//List<String> cassplit = retcasid.split('\\/');
			if(usrtype == 'PowerPartner' && ispartner == true )				
			{
	    		ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Insufficient Privileges: You do not have access to this record.'));
				rend=false;
	
		     }
		    else
		    {
	        	rend=true;
		        	
		    }
	       		
	}

}