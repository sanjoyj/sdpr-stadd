/* Class Name  : CaseControllerExtension_Test
 * Description : Test class for an Apex class CaseControllerExtension 
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class CreateFuncDomainController_Test{
    /*public Integer numberOfRowToRemove=1; 
     private static testmethod void createControllerTest(){       
        Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        test.starttest();
        insert cas; 
        Functional__c fun= new Functional__c();
        fun.Case__c =cas.id;
        fun.Assesor_Role__c ='Test';
        fun.Assessment_Date__c =system.today();
        fun.Summary__c = 'test';
        fun.Functional_Domain_Type__c ='Physical Functioning';
        insert fun;
        Assessment_List__c asList = new Assessment_List__c();
        asList.Case__c =cas.Id;
        asList.Assessment_Name__c = 'Test Name';
        asList.Date_Assessed__c = system.today();
       
       
        Mapping_object__c mapobj = new Mapping_object__c();
        mapobj.Functional_Domain_Type__c = 'FunctionalDomainPage';
        mapobj.Context_prompt__c= 'Test';
        insert mapobj;
         
      
        ApexPages.StandardController sc = new ApexPages.StandardController(cas); 
        CreateFuncDomainController obj = new CreateFuncDomainController (sc);
        
        //obj.assesmentlist = new list<Assessment_List__c> ();
        obj.test = true;    
        
        //obj.assesmentlist.add(asList);
        obj.getcontext();       
        obj.addassesment();
        //obj.removeassesment();      
        obj.SubmitandAdd();
        obj.submit();
 
        test.stoptest();
        system.assertNotEquals(obj.assesmentlist, null);      
    }   
     private static testmethod void createControllerSubmitTest(){       
        Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        test.starttest();
        insert cas; 
        Functional__c fun= new Functional__c();
        fun.Case__c =cas.Id;
        fun.Assesor_Role__c ='Test';
        fun.Assessment_Date__c =system.today();
        fun.Summary__c = 'test';
        fun.Functional_Domain_Type__c ='Physical Functioning';
        insert fun;
        Assessment_List__c asList = new Assessment_List__c();
        asList.Case__c =cas.Id;
        asList.Assessment_Name__c = 'Test Name';
        
        asList.Date_Assessed__c = system.today();
        Mapping_object__c mapobj = new Mapping_object__c();
        mapobj.Functional_Domain_Type__c = 'FunctionalDomainPage';
        mapobj.Context_prompt__c= 'Test';
        insert mapobj;
       
        ApexPages.StandardController sc = new ApexPages.StandardController(cas); 
        CreateFuncDomainController obj = new CreateFuncDomainController (sc);
        obj.test = true;        
        //obj.assesmentlist = new list<Assessment_List__c> ();
        //obj.assesmentlist.add(asList);
        
        obj.submit();
        obj.SubmitandAdd();   
        test.stoptest();        
        system.assertNotEquals(obj.finalUpdateAsseslst, null);
    }   
    
    private static testmethod void createControllerremovetest(){       
        Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        test.starttest();
        insert cas; 
        Functional__c fun= new Functional__c();
        fun.Case__c =cas.Id;
        fun.Assesor_Role__c ='Test';
        fun.Assessment_Date__c =system.today();
        fun.Summary__c = 'test';
        fun.Functional_Domain_Type__c ='Physical Functioning';
        insert fun;
        Assessment_List__c asList = new Assessment_List__c();
        asList.Case__c =cas.Id;
        asList.Assessment_Name__c = 'Test Name';
        
        asList.Date_Assessed__c = system.today();
        Mapping_object__c mapobj = new Mapping_object__c();
        mapobj.Functional_Domain_Type__c = 'FunctionalDomainPage';
        mapobj.Context_prompt__c= 'Test';
        insert mapobj;
       
        ApexPages.StandardController sc = new ApexPages.StandardController(cas); 
        CreateFuncDomainController obj = new CreateFuncDomainController (sc);
        obj.test = true;        
        
        obj.addassesment();
        //obj.removeassesment();
          
        test.stoptest();        
       // system.assertNotEquals(obj.finalUpdateAsseslst, null);
    } */  
}