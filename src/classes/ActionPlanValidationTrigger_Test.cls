/* Class Name  : ActionPlanValidationTrigger_Test
 * Description : Test class for an Apex class for Validation rules
 * Created By  : Balaji Kotte
 * Created On  : 07-08-2014 
*/
@isTest
public with sharing class ActionPlanValidationTrigger_Test {
	
	static case cas;
    static Plan__c plan;
    static Plan_Goal__c goal;
    static Plan_Milestone__c mileStone;
    static Action_Item__c actItem;
    static user usr {get; set;}
    static List<Profile> userPrf{get; set;}
   
    public static testMethod void ActionPlanValidation()
    {
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
        actItem.Activity__c = 'TestPlan_1';
        actItem.Review_Date__c = system.today()+1;
		actItem.Status__c = 'In Progress';
		
        insert actItem;          
        System.debug('****************sActionId :'+ actItem.id );
        
        test.startTest();
         system.assertNotEquals(actItem.Assign_To_Me__c, null);      
        test.stopTest();   
   
       
    }
    
     public static testMethod void ActionPlanUpdateValidation()
    {
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
        actItem.Activity__c = 'TestPlan_2';
        actItem.Review_Date__c = system.today()+1;
		actItem.Status__c = 'In Progress';
		
        insert actItem;          
        System.debug('****************sActionId :'+ actItem.id );
        
        test.startTest();
        userPrf = [select id from profile where name='STADD Navigator' limit 1];
        
        usr = [Select Id from user where profileid  =:userPrf[0].id limit 1];
        
        actItem.Assigned_To__c = usr.id;
	        actItem.Status__c = 'Complete';
	        update actItem;
        
       /* System.runAs(usr)
        {
	        actItem.Assigned_To__c = usr.id;
	        actItem.Status__c = 'Complete';
	        update actItem;
        }*/
         system.assertNotEquals(actItem.Assign_To_Me__c, null);      
        test.stopTest();   
   
       
    }
  
	
	/* private static testmethod void PopulatecontrollerTest()
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
    }   */

}