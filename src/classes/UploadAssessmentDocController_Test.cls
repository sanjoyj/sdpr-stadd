/* Class Name  : UploadAssessmentDocController_Test
 * Description : Test class for an Apex class UploadAssessmentDocController 
 * Created By  : Silviu Frantescu
 * Created On  : 10-01-2013
*/

@isTest
private class UploadAssessmentDocController_Test{
    static case cas;
    static Apexpages.standardcontroller sc;
    static UploadAssessmentDocController obj;
    
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas; 
        ApexPages.currentPage().getParameters().put('id', cas.id);
        sc = new Apexpages.standardcontroller(cas);    
        obj = new UploadAssessmentDocController(sc);
    }
    private static testmethod void attachmentNullTest(){
        test.starttest();
        testData();
        obj.upload();
        obj.Uploadandadd();
        test.stoptest();
        system.assertEquals(obj.vDocument.Name, null);
    }
    private static testmethod void attachmentNotNullTest(){
        test.starttest();
        testData();
        obj.vDocument.Name = 'test doc.txt';
        obj.vDocument.body = blob.valueOf('test body');
        obj.upload();        
       // system.assertEquals(obj.vDocument.Name, '%.txt');
        obj.vDocument.Name = 'test doc.txt';
        obj.vDocument.body = blob.valueOf('test body');
        obj.Uploadandadd();
        system.assertEquals(obj.vDocument.body, null);
        test.stoptest();
    }
    private static testmethod void attachmentExceptionTest(){
        test.starttest();
        testData();
        obj.vDocument.body = blob.valueOf('test body');
        obj.upload();
        obj.casdocument = new Case_Document__c();
        obj.vDocument.Name = 'test doc';
        obj.vDocument.body = blob.valueOf('test body');
        obj.Uploadandadd();        
        system.assertEquals(obj.vDocument.body, null);
        test.stoptest();
    }
}