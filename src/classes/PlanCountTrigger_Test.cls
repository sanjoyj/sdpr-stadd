/* Class Name  : PlanCountTrigger_Test
 * Description : Test class for an Apex trigger PlanCountTrigger
 * Created By  : Silviu Frantescu
 * Created On  : 10-18-2013
*/

@isTest
private class PlanCountTrigger_Test{
    static case cas;
    static plan__c plan;
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas;
        plan = new plan__c();
        plan.name = 'test plan';
        plan.Case__c = cas.id;
        plan.Plan_Status__c ='Active Plan';
        plan.Plan_Type__c = 'Crisis Plan';
        insert plan;
    }
    private static testmethod void testCountMethod(){
        Test.startTest();
        testData();
        plan.Plan_Type__c = 'Normal Plan';
        update plan;
        Test.stopTest();     
        system.assertEquals(plan.Plan_Status__c, 'Active Plan');   
    }
}