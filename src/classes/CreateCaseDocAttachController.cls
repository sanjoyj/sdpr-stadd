/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Case Document Creation
** Description: Create CaseDocument and Attachment from the same page from the Related list for Case and Referral
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           1/20/2013         1.0                   Created** 
**Balaji Kotte				 03/072014		   2.0					 Modifyed for CR# 47
********************************************************************************************/

public without sharing class CreateCaseDocAttachController {
	
	Public Case_Document__c casdoc {get; set;}
	Public Attachment vDocument {get; set;}
	public List<Case>  casrecord{get; set;}
	public List<Referral__c> refrecord{get; set;}
	public List<Account> accrecord{get;set;}
	public string refname{get; set;}
	public string casindiname{get;set;}
	public string casfirstname{get; set;}
	public string refFirstName{get; set;}
	public string prcasindiname{get;set;}
	public string prcasfirstname{get; set;}
	public Id id{get;set;}
	public string recordtypeid{get; set;}
	public string casid{get;set;}
	Public Case_Document__c record {get; set;}
	public List<Protocols_and_Safeguards__c> prorecord{get; set;}
	
	public CreateCaseDocAttachController(ApexPages.StandardController controller) 
	{
        id=  ApexPages.currentPage().getParameters().get('id');
        system.debug('ID  '+id);
        recordtypeid = ApexPages.currentPage().getParameters().get('RecordType');
        system.debug('recordtype '+recordtypeid);
        recordtypeid = recordtypeid.substring(0,15);
        system.debug('recordtype sub '+recordtypeid);
        string retcasid = ApexPages.currentPage().getParameters().get('retURL');
        system.debug('retURL'+retcasid);
        casdoc = new Case_Document__c(RecordTypeId = recordtypeid);
        vDocument = new Attachment();
        casrecord = new List<Case>();
        refrecord = new List<Referral__c>();
        accrecord = new List<Account>();
        prorecord = new List<Protocols_and_Safeguards__c>();
       
        //if(retcasid.startsWith('/'))
        //{ 
        	//retcasid = retcasid.replace('/', '');
        	//retcasid.replace('stadd','');
        	List<String> cassplit = retcasid.split('\\/');
        	if(retcasid.contains('/apex/GoalTaskHomepage'))
        	{
        		system.debug('inside if');
	        	casid = ApexPages.currentPage().getParameters().get(System.Label.Case_Lkid);
        		casid = casid.substring(0,15); 
        		system.debug('lkid'+ casid);
        	}
        	else if(retcasid.contains('GoalTask'))
        	{
        		casid = cassplit[cassplit.size()-2];
	        	casid= casid.substring(0,15);
        	}
        	else if(retcasid.contains(System.Label.Protocol_Id))
	        {
        		casid = cassplit[cassplit.size()-1];
	        	casid = casid.substring(0,15);
	   		}
	   		else if(retcasid.contains(System.Label.Case_Doc_Id))// added for the Case document tab
	   		{
	   			
	   		}
        	else
        	{
	        	casid = cassplit[cassplit.size()-1];
	        	casid = casid.substring(0,15);
        	}
        	 
        // }
	    if(!retcasid.contains(System.Label.Case_Doc_Id)) // added for the Case document tab
	    {    
	        if(casid.contains(System.Label.CaseId))
	        {
	        	system.debug('Casid '+casid); 
	      		casrecord = [select id,Referral__c,AccountId from Case where id =: casid limit 1];
	      		system.debug('casrecord'+ casrecord);
	      		string accid = casrecord[0].AccountId;
	      		
	      		if(accid != null || accid !='')
	      		{	      			
		      		accrecord = [select id,Name,FirstName,LastName from Account where id =:accid limit 1];
		      		if(!accrecord.isempty())
		      		{
			      		casindiname = accrecord[0].LastName;
			      		casfirstname = accrecord[0].FirstName;
		      		}
		      		//casindiname = casfirstname+' '+ casindiname;
		      		system.debug('casname'+casindiname);
		      		//casrecord = casrecord[0].id.substring(0,14);
	      		}
	      		else
	      		{
	      			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'This is not a correct record.Please contact the administrator.'));
	      		}
	       	}
	        if(casid.contains(System.Label.ReferralId))
	        {
	        	system.debug('Casid '+casid); 
	        	refrecord = [select id,Individual_Last_Name__c,Individual_First_Name__c from Referral__c where id =: casid limit 1];	
	        	//system.debug('refrecord'+ refrecord);
	        	if(!refrecord.isempty())
	        	{
		        	refname = refrecord[0].Individual_Last_Name__c;
		        	refFirstName = refrecord[0].Individual_First_Name__c;
	        	}
	        }
	        if(casid.contains(System.Label.Protocol_Id))
	        {
	        	system.debug('Casid '+casid); 
        		prorecord = [select id,Case__c from Protocols_and_Safeguards__c where id =:casid limit 1];
        		string prcasid;
        		if(!prorecord.isempty()){
        			prcasid = prorecord[0].Case__c;
        		}
        		List<Case> pcasrecord = [select id,AccountId from Case where id =: prcasid limit 1];
        		string paccid;
        		if(!pcasrecord.isempty()){
        			paccid = pcasrecord[0].AccountId;
        		}
        		List<Account> accrecord = [select id,Name,FirstName,LastName from Account where id =:paccid limit 1];
        		if(!accrecord.isempty()){
	        		casindiname = accrecord[0].LastName;
			      	casfirstname = accrecord[0].FirstName;
        		}
		      	system.debug('prlastname '+ casindiname);
		      	system.debug('prfirstname '+ casfirstname);
	   		} 
	   		
	   	}   
    }

    public pagereference Submit()
    {
    	//system.debug('Inside Submit>>>>>>>>>');    	  	
    	//if(vDocument.Body != null)
    	//{
    		system.debug('inside vDocument>>>>>>>>>');    		
    		if(casrecord.size()>0)
    		{
				system.debug('inside caserecord>>>>>>>>>');
		    	string casidnew = casrecord[0].Id;
		    	casidnew = casidnew.substring(0,15);
		    	string casrefidnew = casrecord[0].Referral__c;
		    	casrefidnew = casrefidnew.substring(0,15);
		    	system.debug(casrefidnew);
		    	
		    	casdoc.Case__c = casidnew;
			    	//casdoc.Referral__c = casrefidnew; not populating the referral when created from case
    		}
    		if(refrecord.size()>0)
    		{
				system.debug('refrecord caserecord>>>>>>>>>');
    			string refidnew = refrecord[0].Id;
		    	refidnew = refidnew.substring(0,15);
		    	string refname = refrecord[0].Individual_Last_Name__c;
    			system.debug(refidnew);
    			casdoc.Referral__c = refidnew;
    		}
    		if(prorecord.size()>0)
    		{
    			system.debug('protocol caserecord>>>>>>>>>');
    			casdoc.Protocols_and_Safeguards__c = prorecord[0].id;
    			//casdoc.Case__c = 
    		}	
    		
    		try{
	    	insert casdoc;
	    //	vDocument.parentId = casdoc.Id;
	    //	insert vDocument;
    		}
    		catch(exception e){
    				ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'This is not a correct record.Please contact the administrator.'));
    		}
    //	}
    	/*else
    	{
    		ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please attach the required forms'));
            vDocument.body = null;            
            return null;
    	}*/
    
    PageReference refPage = new PageReference('/' + casdoc.Id);                
    refPage.setRedirect(true);	
    return refPage;
    }
    
}