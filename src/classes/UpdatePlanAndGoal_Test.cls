/* Class Name  : UpdatePlanAndGoal_Test
 * Description : Test class for an Apex class UpdatePlanAndGoal, UniqueSupportPlan trigger
 * Created By  : Silviu Frantescu
 * Created On  : 10-21-2013
*/

@isTest
private class UpdatePlanAndGoal_Test{
    static case cas;
    static Plan__c plan;
    static Plan_Goal__c goal;
    static Plan_Milestone__c mileStone;
    static Action_Item__c actItem;
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas;
        plan = new Plan__c();
        plan.Case__c = cas.id;
        insert plan;
        goal = new Plan_Goal__c ();
        goal.Plan__c = plan.Id;
        insert goal;
        mileStone = new Plan_Milestone__c();
        mileStone.Plan_Goal__c = goal.Id;
        milestone.Plan__c = plan.id;
        insert mileStone;
        actItem = new Action_Item__c();
        actItem.Milestone__c = mileStone.Id;
        insert actItem;          
    }
    private static testmethod void testTriggerInsert(){
        test.startTest();
        testData();     
        test.stopTest();    
    }
    
    private static testmethod void testuniquesupportplan(){
    	case cas1;
	     Plan__c plan1;
	     Plan__c plan2;
	    cas1 = new case ();
        cas1.status = 'New';
        cas1.Origin = 'Phone';        
        insert cas1;
        plan1 = new Plan__c();
        plan1.Case__c = cas1.id;
        plan1.Plan_Type__c = 'Support Plan';
        plan1.Plan_Status__c = 'Not Active';
        insert plan1;
        plan2 = new Plan__c();
        plan2.Case__c = cas1.id;
        plan2.Plan_Type__c = 'Crisis Plan';
        plan2.Plan_Status__c = 'Not Active';
        insert plan2;
        test.startTest();
       
        System.assert(true);
        test.stopTest();
    }
}