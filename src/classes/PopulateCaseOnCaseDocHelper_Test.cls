/* Class Name  : PopulateCaseOnCaseDocHelper_Test
 * Description : Test class for an Apex trigger PopulateCaseOnCaseDocHelper 
 * Created By  : Reju Palathingal
 * Created On  : 15-09-2013
 */
@isTest
private class PopulateCaseOnCaseDocHelper_Test {

    static testMethod void PopulateCaseonCD() {
        // TO DO: implement unit test
        
        Case_Document__c ast = new Case_Document__c ();
        ast.Name = 'test';
        ast.Category__c = 'Individual';
        ast.Sub_Category__c = 'Consent';
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Collaborative' and SobjectType ='Case_Document__c' limit 1];
        ast.RecordTypeId = rectype.get(0).id;
        test.starttest();
        insert ast;      
        
        
        system.assertEquals(ast.Case__c, null);    
        test.stoptest();   
    }
}