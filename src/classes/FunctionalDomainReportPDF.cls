/******************************************************************************************
** ICM STADD Project
******************************************************************************************* 
 * @Class Name   : FunctionalDomainReportPDF
 * @Description  : PDF Report controller Class
 * @Created By   : Gaurav Verma
 * @Created On   : 09 Sep 2013
 * @Modification Log:  
 * -----------------------------------------------------------------------------
 * @Developer                Date                  Description 
 * -----------------------------------------------------------------------------
 * @Gaurav Verma          27 Sep 2013               Created
 * 
 * -----------------------------------------------------------------------------
 */
public with sharing class FunctionalDomainReportPDF
{
    public id csid {get;set;}
    public string fundom {get;set;}
    public List<Functional__c> FdLst1 {get;set;}
    public List<Functional__c> FdLst2 {get;set;}
    public List<Functional_Domain_Update__c> current {set; get;}
    public Map<id,List<Functional_Domain_Update__c>> mapFdUpdate {get;set;}
   
    public FunctionalDomainReportPDF()
    {
        csid = ApexPages.currentPage().getParameters().get('id');
        fundom = ApexPages.currentPage().getParameters().get('fundom');
        System.debug('####%%%%%%%%>>>>>' +csid);        
      
      FdLst1 = [select id, name,
                                             Assesor_Role__c, 
                                             Case__c, 
                                             CreatedByid,
                                             CreatedDate, // MH 26/9/13
                                             Assessor_Name_formula__c, // MH 26/9/13
                                             LastModifiedByid,
                                             //Ownerid,
                                             Date_of_Birth__c,
                                             
                                             Case__r.Contact.Birthdate,
                                             
                                             Assessor_Name__c,
                                             Assessor_First_Name__c,
                                             Assessor_Last_Name__c , 
                                             Case_Name__c,
                                             Individual_Name__c,
                                             Cross_Reference_Domain_s__c,   
                                             Functional_Domain_Type__c, 
                                             Other_Functional_Domain__c, 
                                             Summary__c ,
                                             (Select Id, Name, Update__c, createddate From Functional_Domain_Updates__r)                                      
                                             from Functional__c 
                                             where (Functional_Domain_Type__c =:fundom  AND Case__c =:csid)
                                             ];
                                             //Reshma added for enhancement of print all functionality    
        FdLst2 = [select id, name,
                                             Assesor_Role__c, 
                                             Case__c, 
                                             CreatedByid,
                                             CreatedDate, // MH 26/9/13
                                             Assessor_Name_formula__c, // MH 26/9/13
                                             LastModifiedByid,
                                             //Ownerid,
                                             Date_of_Birth__c,
                                             
                                             Case__r.Contact.Birthdate,
                                             
                                             Assessor_Name__c,
                                             Assessor_First_Name__c,
                                             Assessor_Last_Name__c , 
                                             Case_Name__c,
                                             Individual_Name__c,
                                             Cross_Reference_Domain_s__c,   
                                             Functional_Domain_Type__c, 
                                             Other_Functional_Domain__c, 
                                             Summary__c ,
                                             (Select Id, Name, Update__c, createddate From Functional_Domain_Updates__r)                                      
                                             from Functional__c 
                                             where (Case__c =:csid)
                                             ORDER BY Functional_Domain_Type__c, name
                                               ];
         
                system.debug('####%%%%%%%% query>>>' + fundom+ '##Case ID##' + csid );
                //system.debug('####FdLst1[0].Functional_Domain_Type__c%%%%%%%% query>>>' + FdLst1[0].Functional_Domain_Type__c);
                //system.debug('####%%%%%%%%  FdLst1.size>>>' + FdLst1.size());
        if(FdLst1.size()>0) 
        {
            mapFdUpdate = new    Map<id,List<Functional_Domain_Update__c>>(); 
            for(Functional__c F: FdLst1)
            {
                list <Functional_Domain_Update__c> current = new list <Functional_Domain_Update__c>();
                current = F.Functional_Domain_Updates__r;
                mapFdUpdate.put (F.id,current) ; 

            }
        }
        
       else if(FdLst2.size()>0) 
        {    
           
            mapFdUpdate = new  Map<id,List<Functional_Domain_Update__c>>(); 
            for(Functional__c F: FdLst2)
            {
                
                list <Functional_Domain_Update__c> current = new list <Functional_Domain_Update__c>();
                current = F.Functional_Domain_Updates__r;
                mapFdUpdate.put (F.id,current) ; 

            }
        }
        else
        {
            ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, 'No Functional Domain with this Type available in the system'));
            //Return Null;
        }                                        
       
    }
   }
  
    /*public pagereference printplan(){
        
        PageReference refPage = new PageReference('/apex/FuncDomainPrintPreview?id='+ csid) ;                
        refPage.setRedirect(true);       
        
    return refPage;
    }
    }*/