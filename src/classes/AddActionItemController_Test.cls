/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 * 
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AddActionItemController_Test {
     static case cas;
    static testMethod void TestData() {
        cas = new case();
        cas.Status = 'New';
        insert cas;
        Plan__c plan = new Plan__c ();
        plan.Case__c = cas.Id;
        insert plan;
        Plan_Goal__c goal = new Plan_Goal__c ();
        goal.Plan__c = plan.Id;
        goal.Status__c = 'Active';
        insert goal;
        Plan_Milestone__c milestone = new Plan_Milestone__c ();
        milestone.Plan_Goal__c = goal.Id;
        milestone.Plan__c = plan.id;
        milestone.Status__c = 'Active';
        insert milestone;
        // TO DO: implement unit test
    }
    private static testmethod void testCloseCase(){
        test.startTest();
        try{
            testData();
            //ApexPages.StandardController sc = new ApexPages.StandardController(ref);
            AddActionItemController obj = new AddActionItemController();
        }
        catch(Exception ex){
            //Expected
        }
        test.stopTest();
    }

}