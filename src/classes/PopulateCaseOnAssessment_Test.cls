/* Class Name  : CaseControllerExtension_Test
 * Description : Test class for an Apex trigger PopulateCaseOnAssessment 
 * Created By  : Reju Palathingal
 * Created On  : 10-03-2013
*/

@isTest

public with sharing class PopulateCaseOnAssessment_Test 
{
     private static testmethod void PopulatecontrollerTest()
     {    
     	Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas; 
        Assessment_List__c ast = new Assessment_List__c ();
        ast.Assessment_Name__c = 'test';
        ast.Date_Assessed__c = system.today();
        ast.Credential_Role_of_Assessor__c ='pro';
        ast.Case__c = cas.id;
        test.starttest();
        insert ast;      
        
        
       system.assertNotEquals(ast.Case__c, null);      
        test.stoptest();   
    }   

}