/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Functional domain wizard
** Description: Creation of the functional domain, assessment recods and navigate to upload documents controller.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           25/9/2013         1.0                   Created** 
**
********************************************************************************************/

public class CreateFuncDomainController 
{
    Case cs;
    public Boolean test{get; set;}
    public List<Assessment_List__c> assesmentlist{get;set;} 
   // public Assessment_List__c astlst{get;set;}
    public Mapping_object__c mapobj{get; set;}
    public Mapping_object__c mapobjText{get; set;}
    public Functional__c funcdom {get;set;} 
    public List<Assessment_List__c> finalUpdateAsseslst{get; set;}
    public List<Assessment_List__c> errorlist{get; set;}
    public List<Assessment_List__c> insertlist{get; set;}
    public boolean isButtonDisabled {get; set;}
    String result = '';
    public String caseid{get;set;}
    public Integer numberOfRowToRemove { get; set; }
    public Integer rowNumber {get; set;}
        
            
        //Controller for creating a new Functional Document
    public CreateFuncDomainController(ApexPages.StandardController controller) 
    {
        funcdom = new Functional__c();      
        mapobj = new Mapping_object__c();
        
        mapobjText = [select id,Functional_Domain_Type__c,Context_prompt__c 
                                from Mapping_object__c where Functional_Domain_Type__c = 'FunctionalDomainPage' LIMIT 1];
        assesmentlist =  new List<Assessment_List__c>();
        
                cs = (case)controller.getrecord();
                caseid= cs.Id;
                assesmentlist.add(new Assessment_List__c());
                
                //predefault the userfirstname and lastname for assessment records
                for(Assessment_List__c alst : assesmentlist)
                {
                        alst.Assessor_First_Name__c = UserInfo.getFirstName();
                        alst.Assessor_Last_Name__c = UserInfo.getLastName();
                }
                
    }  
    //Fetch the context from Mapping Object
    public PageReference getcontext()
    {
        try
        {           
            mapobj = [select id,Functional_Domain_Type__c,Context_prompt__c 
                                from Mapping_object__c 
                                where Functional_Domain_Type__c =: funcdom.Functional_Domain_Type__c LIMIT 1];               
        }
        catch(exception e)
        {
            String result = System.Label.Create_Functional_Domain_2; //You do not have a helptext
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, result));
        }   
            return null;
    }
    
    //Add new assesment section  
    public PageReference addassesment()
    {
    	if(assesmentlist.size()< 4)
    	{
    		assesmentlist.add(new Assessment_List__c());
        
       		for(Assessment_List__c lst : assesmentlist){    
        
        	lst.Assessor_First_Name__c = UserInfo.getFirstName();
            lst.Assessor_Last_Name__c = UserInfo.getLastName();
        	}
    	}
        else if(assesmentlist.size()== 4)
        {
        	assesmentlist.add(new Assessment_List__c());
        	for(Assessment_List__c lst : assesmentlist){    
        
        	lst.Assessor_First_Name__c = UserInfo.getFirstName();
            lst.Assessor_Last_Name__c = UserInfo.getLastName();
        	}
        	isButtonDisabled = true; //disable the add button
        }   
        
    return null;    
    }   
    
    //Delete the Assesment section
    public PageReference removeassesment()
    {
	    assesmentlist.remove(numberOfRowToRemove);
	        if(assesmentlist.size()<5)
	        {
	                isButtonDisabled = false; //enable the add button
	        }
          
    return null;    
    }   
    
    public PageReference SubmitandAdd()
    {
        try{        
                  
                        finalUpdateAsseslst = new list<Assessment_List__c>();
                        errorlist = new list<Assessment_List__c>();
                        insertlist = new list<Assessment_List__c>();
                        if(test == true)
                        {
                                for(Assessment_List__c ast : assesmentlist)               
                                {
                                        //checks for any of the 3 fields are populated, then assessment gets created
                                        if(ast.Assessment_Name__c != null || ast.Date_Assessed__c != null || ast.Notes__c != null)
                                        {
                                
                                if(ast.Assessment_Name__c != null && ast.Date_Assessed__c != null)
                                                {  
                                                        finalUpdateAsseslst.add(ast);
                                                }   
                                                else
                                                {
                                                        errorlist.add(ast);//list creates the warning message for the required fields for assessment
                                                }   
                                        }   
                                }
                                if(errorlist.size() >0)
                                {                       
                                system.debug('error');
                                String result = System.Label.Create_Functional_Domain_1; //Please complete the assessment details
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, result));                          
                                return null;   
                                }      
                                else
                                {
                                funcdom.Case__c = cs.Id;

                                insert funcdom;

                                if(finalUpdateAsseslst.size() >0)
                                { 
                                    for(Assessment_List__c fin : finalUpdateAsseslst)
                                     {
                                            fin.Functional_Domain__c = funcdom.id;
                                            //fin.Case__c = cs.Id;                          
                                            
                                            insertlist.add(fin);
                                     }               
                                     insert insertlist;//inserts the Assessments
                                 }

                                }
                }
                        else
                        {
                                funcdom.Case__c = cs.Id;
                                insert funcdom;// inserts functional domain record
                        }  
                }            
                     
            
        catch (DMLException e) 
                {
                      String result = System.Label.Create_Functional_Domain_3; //Please contact the administrator
                          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, result));
                      return null;
                 } 
        finally{
                }   
                PageReference refPage = new PageReference('/apex/uploadAssesmentDoc?id='+ cs.Id) ;              
                refPage.setRedirect(true);
                return refPage; 
    }
    

        
    public PageReference submit() // MH+SF: changed from "save" to "submit" 27/9/2013
    {
        
        try{                
                   
                  finalUpdateAsseslst = new list<Assessment_List__c>();
                  errorlist = new list<Assessment_List__c>();
                  insertlist = new list<Assessment_List__c>();
                  if(test == true)
                  {
                          for(Assessment_List__c ast : assesmentlist)               
                          {
                                //checks for any of the 3 fields are populated, then assessment gets created
                                if(ast.Assessment_Name__c != null || ast.Date_Assessed__c != null || ast.Notes__c != null)
                                                {       
                                        if(ast.Assessment_Name__c != null && ast.Date_Assessed__c != null)
                                        {  
                                        finalUpdateAsseslst.add(ast);
                                        }   
                                    else
                                    {
                                        errorlist.add(ast);//list creates the warning message for the required fields for assessment
                                    }   
                                                }
                          }
                          if(errorlist.size() >0)
                          {                       
                                system.debug('error');
                                                String result = System.Label.Create_Functional_Domain_1; //Please complete the assessment details
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, result));                
                              return null;   
                          }      
                          else
                          {
                                funcdom.Case__c = cs.Id;
                                
                                insert funcdom;
                              
                                if(finalUpdateAsseslst.size() >0)
                                      { 
                                        for(Assessment_List__c fin : finalUpdateAsseslst) {
                                                fin.Functional_Domain__c = funcdom.id;
                                                //fin.Case__c = cs.Id;                          
                                                
                                                insertlist.add(fin);
                                        }               
                                        insert insertlist;//inserts the Assessments
                                      }
                        
                                }
                      }
                  else
                  {
                        funcdom.Case__c = cs.Id;
                            insert funcdom;// inserts functional domain record
                                        }  
        }            
            
        catch (DMLException e) 
                {
                      String result = System.Label.Create_Functional_Domain_3; //Please contact the administrator
                          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, result));                      
                      return null;
                 } 
        finally{
                }   
    
                PageReference refPage = new PageReference('/' + funcdom.Id);                
                refPage.setRedirect(true);
                return refPage;
    }
         
}