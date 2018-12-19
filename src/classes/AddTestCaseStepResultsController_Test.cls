/* Class Name  : AddTestCaseStepResultsController_Test
 * Description : Test class for an Apex class AddTestCaseStepResultsController
 * Created By  : Silviu Frantescu
 * Created On  : 10-03-2013
*/

@isTest
private class AddTestCaseStepResultsController_Test{
    static Test_Case__c testCase;
    static Test_Case_Step__c testCaseStep;
    static list<Test_Case_Step__c> testCaseStepList;
    static Test_Case_Result__c tsResult;
    static list<Test_Case_Result__c> tsResultList;
    
    private static testmethod void testdata(){
        testCase = new Test_Case__c();
        insert testCase;         
        testCaseStep= new Test_Case_Step__c(Test_Case__c=testCase.Id);
        insert testCaseStep;         
        testCaseStepList = new list<Test_Case_Step__c>();
        testCaseStepList.add(TestCaseStep);
        tsResult = new Test_Case_Result__c(Test_Case_Step__c=testCaseStep.Id);
        insert tsResult;         
        tsResultList = new list<Test_Case_Result__c>();
        tsResultList.add(tsResult);
    }

    private static testmethod void testCaseControllerTest(){          
        test.startTest();
        testdata();
        ApexPages.currentPage().getParameters().put('id',testCase.Id);         
        AddTestCaseStepResultsController Obj = new AddTestCaseStepResultsController();
        Obj.SelecteResultRecord = tsResult.id; 
        Obj.editRecord();
        Obj.editResult();
        Obj.Cancel_Click();
        Obj.addNewResult();
        Obj.getTestCaseStepResults();
        Obj.AddTestCaseStepResult();
        Obj.CancelTestCaseStepResult();
        Obj.getTestResult();
        Obj.getTestCaseSteps();
        Obj.setTestCaseSteps(testCaseStepList);
        Obj.settestcaseresultobj(tsResult);
        Obj.gettestcase();
        Obj.DeleteResult();
        Obj.getUserInfo();
        Obj.settestcase(testCase);
        Obj.setTestCaseResults(tsResultList );
        Obj.gettestcaseresultobj();
        Obj.SelecteResultRecord = null;
        Obj.DeleteResult();
        test.stopTest();
        system.assertEquals(Obj.SelecteResultRecord, null);
    }
     private static testmethod void testCaseControllerExceptionTest(){          
        test.startTest();
        testdata();
        ApexPages.currentPage().getParameters().put('id',testCase.Id);         
        AddTestCaseStepResultsController Obj = new AddTestCaseStepResultsController();
        Obj.tsResult= new Test_Case_Result__c(); 
        Obj.editResult();
        system.assertNotEquals(Obj.tsResult, null);
    }
    
    
}