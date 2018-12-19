/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Upload documents
** Description: Upload the assessment documents for the case.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           27/9/2013         1.0                   Created** 
**
********************************************************************************************/

public without sharing class UploadAssessmentDocController {

	public id csid{get;set;}
	public Case casrecord{get;set;}
    public Case_Document__c casdocument{get;set;}
    public Attachment vDocument{get; set;} 
    public List<Account> acclst{get; set;} 
    public String accname{get;set;}
    public String accfirstname{get;set;}
    public id recdid{get; set;}
//Constructor

	public UploadAssessmentDocController(ApexPages.StandardController controller) 

	{
		csid = ApexPages.currentPage().getParameters().get('id');
		casdocument = new Case_Document__c();
		casdocument.Category__c = 'Assessment'; //GV
		vDocument = new Attachment();
		
		recdid = controller.getId();
		Case record = [select id,AccountId from Case where id =:recdid limit 1];
		string casaccid = record.AccountId;
		system.debug(casaccid);
		acclst = [select id,Name,LastName,FirstName from Account where id =:casaccid limit 1];
		if(acclst.size()>0)
		{
			accname = acclst[0].LastName;
			accfirstname =acclst[0].FirstName;
			system.debug('accname'+accname);
		}
	}
	// Logic for upload button
	public PageReference Upload()
	{
		if(vDocument.Body != null){
		try{
			System.debug('####%%%%%%%%GV>>>>>' +csid + vDocument.Body);
			
						
			List<RecordType> casdocrectype2 =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Document__c' limit 1];
            casdocument.RecordTypeId = casdocrectype2.get(0).id;
			casdocument.Case__c = csid;
			casdocument.Category__c = 'Assessment';
			casdocument.Name = 'Assessment'+ '-'+casdocument.Sub_Category__c;
			insert casdocument;
			
			string dname = vDocument.Name;
			//List<String> parts = dname.split('\\.');                                      
      		//string split = parts[parts.size()-1];       		
      		//vDocument.Name = casdocument.Sub_Category__c+'.'+split;  Commented as not required post CC  release post R1.2
      		
			vDocument.ParentId = casdocument.id;
			insert vDocument;
			}
			
		Catch(exception e){
			String MSG = System.Label.Upload_Doc_4; //Please contact the administrator
        	ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, MSG));
            return null;
			
		}
		finally{
			vDocument.body = null;
			
		}

		PageReference refPage = new PageReference ('/' + csid);              
	    refPage.setRedirect(true);
	    return refPage;	
    	}
		else
		{
			System.debug('####%%%%%%%%GV>>>>>' +csid + vDocument.Body);
			String MSG = System.Label.Upload_Doc_1;
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, MSG));
		return null;	
		}
	}
	//Logic for Upload and Add button
	public PageReference Uploadandadd()
	{
		if(vDocument.Body != null){
		try{
			
			System.debug('####%%%%%%%%>>>>>' +csid);
			List<RecordType> casdocrectype2 =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Document__c' limit 1];
            casdocument.RecordTypeId = casdocrectype2.get(0).id;
			casdocument.Case__c = csid;
			casdocument.Category__c = 'Assessment';
			casdocument.Name = 'Assessment'+ '-'+casdocument.Sub_Category__c;
			insert casdocument;
			
			string dname2 = vDocument.Name;			
			//List<String> parts1 = dname2.split('\\.');                                      
      		//string split2 = parts1[parts1.size()-1]; 
      		
      		//vDocument.Name = casdocument.Sub_Category__c+'.'+split2;  Commented as not required post CC  release post R1.2
			vDocument.ParentId = casdocument.id;
			insert vDocument;
			
		  }
		Catch(exception e){
			
			String MSG = System.Label.Upload_Doc_2;  //Please attach the documents
        	ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, MSG));
			
            return null;
			
		}
		finally{
			vDocument.body = null;
			
		}
		
		
		PageReference refPage = new PageReference('/apex/uploadAssesmentDoc?id='+ csid);              
	    refPage.setRedirect(true);
	    return refPage;
		}	
    else
		{
			System.debug('####%%%%%%%%GV>>>>>' +csid + vDocument.Body);
			String MSG = System.Label.Upload_Doc_3;//Please choose the file before uploading
        	ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, MSG));
		return null;	
		}
	}
	
}