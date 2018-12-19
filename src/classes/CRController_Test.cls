/* Class Name  : CRController_Test
 * Description : Test class for an Apex class CRController
 * Created By  : Silviu Frantescu
 * Created On  : 10-03-2013
*/

@isTest
private class CRController_Test{
    private static testMethod void ControllerTest() {
        Project__c proj = new Project__c(Name = 'Test Project', Project_Summary__c = 'Test', Project_Status__c = 'In Progress');
        insert proj;
        Release__c rel = new Release__c(Name = 'Test Release', Type__c = 'Major', Status__c = 'In Progress', Start_Date__c = Date.Today(), End_Date__c = Date.Today() + 1, Project__c = proj.Id);
        insert rel;
        Work_Package__c wp = new Work_Package__c(Status__c = 'In Progress', Priority__c = 'Medium', Release__c = rel.Id);
        insert wp;
        Change_Request__c cr = new Change_Request__c(Status__c = 'Submitted for approval', Summary__c = 'Test', Work_Package__c = wp.Id);
        insert cr;
        List<Component__c> compList = new List<Component__c>{new Component__c(Work_Package__c = wp.Id, Name = 'Test1'), new Component__c(Work_Package__c = wp.Id, Name = 'Test2')};
        insert compList;
        Id cmpId;
        for(Component__c cmp : compList){
            cmpId = cmp.Id;
            break;
        }
        CR_Components_Join__c crj = new CR_Components_Join__c(Change_Request__c = cr.Id, Component__c = cmpId);
        insert crj;
        Test.startTest();
        CRController pageCon = new CRController(new ApexPages.StandardController(cr));
        for(CRController.ComponentWrapper wrp :  pageCon.componentList){
            if(!wrp.created){
                wrp.selected = true;
            }
        }
        pageCon.attach();
        pageCon.addRows();
        pageCon.createCompNJoin();
        pageCon.newCompList = compList.clone();
        pageCon.createCompNJoin();
        pageCon.newCompList = null;
        pageCon.createCompNJoin();
        Test.stopTest();
        system.assertEquals(pageCon.newCompList, null);
    }
}