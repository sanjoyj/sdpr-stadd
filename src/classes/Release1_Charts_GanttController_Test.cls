/* Class Name  : Release1_Charts_GanttController_Test
 * Description : Test class for an Apex class Release1_Charts_GanttController 
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class Release1_Charts_GanttController_Test{
    private static testMethod void granttControllerTest() {
        Test.startTest();
        Project__c proj = new Project__c(Name = 'Test Project', Project_Summary__c = 'Test', Project_Status__c = 'In Progress');
        insert proj;
        Release__c rel = new Release__c(Name = 'Test Release', Type__c = 'Major', Status__c = 'In Progress', Start_Date__c = Date.Today(), End_Date__c = Date.Today() + 1, Project__c = proj.Id);
        insert rel;        
        Release1_Charts_GanttController pageCon = new Release1_Charts_GanttController();
        pageCon.myTarget = proj.Id;
        pageCon.getProjectGanttJson();
        system.assertNotEquals(pageCon.projectGanttJson, null);
        Release1_Charts_GanttController pageConRel = new Release1_Charts_GanttController();
        pageConRel.myTarget = rel.Id;
        pageConRel.getProjectGanttJson();
        system.assertNotEquals(pageConRel.projectGanttJson, null);
        Test.stopTest();
    }
}