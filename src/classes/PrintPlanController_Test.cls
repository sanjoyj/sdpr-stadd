@isTest
public with sharing class PrintPlanController_Test {
    private static case cas;
    private static Plan__c Pln;
    private static Plan_Goal__c goal;
    private static Plan_Milestone__c Milestone;
    private static Action_Item__c ActionItem ;
    private static Plan_Goal__c goal1;
    private static Plan_Milestone__c Milestone1;
    private static Action_Item__c ActionItem1 ;
    private static Action_Item__c ActionItem2 ;
    
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas;
        Pln = new Plan__c(Name = 'ABC', Plan_Type__c = 'Support Plan', Plan_Status__c = 'Completed', Case__c = cas.Id);
        insert pln;
        goal = new Plan_Goal__c(Name = 'ABC', Area_of_Importance__c = 'Rights', Status__c = 'Completed', Important_steps_to_reach_this_goal__c = 'ACB', Plan__c = pln.id);
        insert goal;
        goal1 = new Plan_Goal__c(Name = 'AsaBC', Area_of_Importance__c = 'Rights', Status__c = 'Completed', Important_steps_to_reach_this_goal__c = 'ACB', Plan__c = pln.id);
        insert goal1;
        Milestone = new Plan_Milestone__c(Name = 'ABC', Status__c = 'Completed', Plan_Goal__c = goal.id, Plan__c = Pln.id );
        insert Milestone;
        Milestone1 = new Plan_Milestone__c(Name = 'ABxSC', Status__c = 'Completed', Plan_Goal__c = goal.id, Plan__c = Pln.id );
        insert Milestone1;
        ActionItem= new Action_Item__c(Activity__c = 'Abcq', Status__c = 'Complete', Review_Date__c = system.Today(), Milestone__c = Milestone.id);
        insert ActionItem;
        ActionItem1= new Action_Item__c(Activity__c = 'Abadscq', Status__c = 'Complete', Review_Date__c = system.Today(), Milestone__c = Milestone.id);
        insert ActionItem1;
        ActionItem2= new Action_Item__c(Activity__c = 'Abadsews', Status__c = 'Complete', Review_Date__c = system.Today(), Milestone__c = Milestone.id);
        insert ActionItem2;
        //milestone
    }    
    private static testmethod void constructorExceptionTest(){
        test.starttest();
        testData();
        ApexPages.currentPage().getParameters().put('id',pln.Id);
        ApexPages.StandardController sc = new ApexPages.StandardController(pln);
        PrintPlanController obj = new PrintPlanController(sc);
        //system.assertEquals(obj.GoalLst1.size(), 1);
        test.stoptest();
        
    }
   /*private static testmethod void constructorInsertionTest(){       
        
        test.starttest();
        testData();
        ApexPages.currentPage().getParameters().put('id', cas.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(pln);
        PrintPlanController obj1 = new PrintPlanController(sc);
        test.stoptest();
        system.assertEquals(obj1.GoalLst1.size(), 1);
    }*/
       
}