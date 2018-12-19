/** ICM STADD Project Enhancements
*******************************************************************************************
** Class Name: SendEmailAndUpdateGoalType_Test.cls
** Description: Test class which includes the test class coverage for SendEmailToCaseTeam class and Update Goal Type trigger
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**sanjoy Joseph          1/16/2016         1.0                   Created** 

********************************************************************************************/
@isTest
private class SendEmailAndUpdateGoalType_Test {
 
    @isTest static void TestFunction() {
       
        //insert case object and case team members
        
       insert new Case(Subject = 'testCase',Description = 'Test',Region__c = 'Northern Region', Status = 'Picture');
       User testUser = new User(); 
       testUser.FirstName = 'TestFname';
       testUser.LastName  = 'TestLname';
       testUser.Email     = 'samplemail@gov.bc.ca';
       testUser.Username  = 'samplemail@gov.bc.ca';
       testUser.Alias     = 'test';
       profile p = [SELECT id,Name FROM Profile WHERE Name = 'System Administrator'];
       testUser.ProfileId = p.id;
       testUser.TimeZoneSidKey    = 'America/Denver';
       testUser.LocaleSidKey      = 'en_US';
       testUser.EmailEncodingKey  = 'UTF-8';
       testUser.LanguageLocaleKey = 'en_US';  
       insert testUser;    
       CaseTeamRole role = [Select ID from CaseTeamRole LIMIT 1];
       Case caseinstance=[SELECT Id FROM Case WHERE Subject = 'testCase' LIMIT 1];
       User userinstance=[SELECT Id FROM User WHERE FirstName = 'TestFname' LIMIT 1];
       insert new CaseTeamMember(ParentID = caseinstance.ID, MemberID = userinstance.ID, TeamRoleID = role.ID);  
        
        //insert child object record
        insert new Plan__c(Name = 'test123',Plan_Type__c = 'Crisis Plan',Plan_Status__c = 'Draft In Progress', Case__c = caseinstance.Id);
        Plan__c planinstance=[SELECT Id FROM Plan__c WHERE Name = 'test123' LIMIT 1];
        insert new  Support_and_Service__c(Service_Support_Type__c = 'SST',Notes__c = 'notes_ss',Case__c = caseinstance.Id);
        Support_and_Service__c childinstance1=[SELECT Id FROM Support_and_Service__c WHERE Service_Support_Type__c = 'SST' LIMIT 1];
        insert new Plan_Goal__c(Name = 'testgoal',Status__c = 'Active',Plan__c = planinstance.Id);
        Plan_Goal__c childinstance2=[SELECT Id FROM Plan_Goal__c WHERE Name = 'testgoal' LIMIT 1];
        insert new Plan_Milestone__c(Name = 'testmilestone',Status__c = 'Active',Plan__c = planinstance.Id,Plan_Goal__c=childinstance2.id);
        Plan_Milestone__c childinstance3=[SELECT Id FROM Plan_Milestone__c WHERE Name = 'testmilestone' LIMIT 1];
        
        //test the SendEmailToCaseTeam apex class
        SendEmailToCaseTeam.SendEmail (caseinstance.Id,childinstance1.Id);
        SendEmailToCaseTeam.SendEmail (caseinstance.Id,childinstance2.Id);
        SendEmailToCaseTeam.SendEmail (caseinstance.Id,childinstance3.Id);
        //test the Update_Gol_Type trigger
        insert new Plan_Goal__c(Name = '*',Goal_Type__c = 'Positive Relationships',Status__c = 'Active',Plan__c = planinstance.Id);
        Plan_Goal__c childinstance4=[SELECT Id,Name,Goal_Type__c FROM Plan_Goal__c WHERE Name = 'Positive Relationships' LIMIT 1];
        system.assertEquals(childinstance4.Name, childinstance4.Goal_Type__c);    
        
    }}