@isTest
private class PreventDeleteOnNotes_Test {

    private static testmethod void testTriggerDelete(){
        test.startTest();
        
        case cas = new case();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas;
        Plan__c plan = new Plan__c();
        plan.name = 'test plan';
        plan.Case__c = cas.id;
        plan.Plan_Status__c ='Active Plan';
        plan.Plan_Type__c = 'Crisis Plan';
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
        Action_Item__c actitem = new Action_Item__c();
        actitem.Status__c = 'In Progress';
        actitem.Review_Date__c = system.today();
        actitem.Milestone__c = milestone.id;
        //actitem.Plan__c = plan.id;
        insert actitem; 
        
        Note note = new Note(title='Attachment',parentid=actitem.id);
        insert note;
             
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@gov.bc.ca', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                 LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com.testUser');         
        System.runAs(u) 
        {  
           Try
           {
           	 delete note;
           }
           Catch(exception ex)
           {
           		//system.assertNotEquals(attachment.adderror., null);
           }
        }    
        test.stopTest();    
    }
}