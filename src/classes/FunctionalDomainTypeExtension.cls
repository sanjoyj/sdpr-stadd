/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** @Class Name   : FunctionalDomainTypeExtension
** @Description  : Let the user chose the Functional Domain type for the case.
** @Created By   : Gaurav Verma
** @Created On   : 09 Sep 2013
** @Modification Log:  
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Gaurav Verma             27/9/2013         1.0                   Created** 
**
******************************************************************************************/
public with sharing class FunctionalDomainTypeExtension {

    public List<Functional__c> FdLst1 {get;set;}
    
    Case CS1;
    //COnstructor for the controller
    public FunctionalDomainTypeExtension(ApexPages.StandardController controller) 
    {
        CS1 = (case)controller.getrecord();
    }
    
    public Functional__c FD1 {
      get{
          if(FD1== null) FD1= new Functional__c();
          return FD1;
         }
         set;
       }
    // Fetch and display records
    public  pagereference Next()
    {                                                               
        List<Functional__c> FdLst1 = [select id, Functional_Domain_Type_For_Print__c from Functional__c where (Functional_Domain_Type__c =: FD1.Functional_Domain_Type_For_Print__c AND Case__c =:CS1.Id)];
        
        //PageReference refPage = Page.FunctionalDomainReportPDF ;
        if(FdLst1.size()>0)
        {
            PageReference refPage = new PageReference('/apex/FunctionalDomainReportPDF1?id='+ CS1.Id + '&fundom=' + FD1.Functional_Domain_Type_For_Print__c) ;
            refPage.setRedirect(true);          
            Return refPage;
        }
        else if(FD1.Functional_Domain_Type_For_Print__c == 'All')
        {
            List<Functional__c> FdLst2 = [select id, Functional_Domain_Type_For_Print__c from Functional__c where (Case__c =:CS1.Id)];
            PageReference refPage2 = new PageReference('/apex/FunctionalDomainReportPDF2?id='+ CS1.Id ) ;
            refPage2.setRedirect(true);          
            Return refPage2;            
        }
       else
       {
          String MSG = System.Label.Error_on_Functional_Update_Report1;
          ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, MSG));  
          Return Null;          
        }

    }

}