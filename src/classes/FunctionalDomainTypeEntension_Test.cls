/* Class Name  : FunctionalDomainTypeEntension_Test
 * Description : Test class for an Apex class CaseControllerExtension 
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class FunctionalDomainTypeEntension_Test{
    private static case cas;
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas;        
    }    
    private static testmethod void CaseControllerTest(){        
        test.startTest();
        testData();
        ApexPages.StandardController sc = new ApexPages.StandardController(cas); 
        FunctionalDomainTypeExtension obj = new FunctionalDomainTypeExtension(sc);
        obj.Next();   
        test.stopTest();
        system.assertEquals(obj.FdLst1, null);
    }    
    private static testmethod void CaseControllerFuncObjTest(){        
        test.startTest();
        testData();
        ApexPages.StandardController sc = new ApexPages.StandardController(cas); 
        FunctionalDomainTypeExtension obj = new FunctionalDomainTypeExtension(sc);
        Functional__c funcObj = new Functional__c(Case__c= cas.id);
        insert funcObj;
       
        obj.Next();
        test.stopTest();
        system.assertNotEquals(funcObj, null);
    }
    private static testmethod void CaseControllerFuncObjTest1(){        
        test.startTest();
        testData();
        ApexPages.StandardController sc = new ApexPages.StandardController(cas); 
        FunctionalDomainTypeExtension obj = new FunctionalDomainTypeExtension(sc);
        Functional__c funcObj = new Functional__c(Case__c= cas.id);
		funcObj.Functional_Domain_Type__c = 'Physical Functioning';
        funcObj.Functional_Domain_Type_For_Print__c = 'All';
        insert funcObj;
       
        obj.Next();
        test.stopTest();
        system.assertNotEquals(funcObj, null);
    }
}