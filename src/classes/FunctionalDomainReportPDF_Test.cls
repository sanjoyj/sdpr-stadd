/* Class Name  : FunctionalDomainReportPDF_Test
 * Description : Test class for an Apex class FunctionalDomainReportPDF
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class FunctionalDomainReportPDF_Test{
    private static testmethod void constructorExceptionTest(){
        test.starttest();
        FunctionalDomainReportPDF obj = new FunctionalDomainReportPDF();
        test.stoptest();
        system.assertEquals(obj.FdLst1.size(), 0);
    }
    private static testmethod void constructorInsertionTest(){       
        Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        test.starttest();
        insert cas; 
        Functional__c funRec = new Functional__c(Case__c=cas.id);
        insert funRec;
        ApexPages.currentPage().getParameters().put('id', cas.id);
        FunctionalDomainReportPDF obj = new FunctionalDomainReportPDF();
        test.stoptest();
        system.assertEquals(obj.FdLst1.size(), 1);
        
    }
     private static testmethod void constructorInsertionTest2(){       
        Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        test.starttest();
        insert cas; 
        Functional__c funRec = new Functional__c(Case__c=cas.id);
        funRec.Functional_Domain_Type__c ='Physical Functioning';
        insert funRec;
        ApexPages.currentPage().getParameters().put('id', cas.id);
        FunctionalDomainReportPDF obj = new FunctionalDomainReportPDF();
        obj.fundom = 'A';
        test.stoptest();
        system.assertEquals(obj.FdLst2.size(), 1);
        
    }
}