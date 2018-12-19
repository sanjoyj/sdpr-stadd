/* Class Name  : CaseAlertCountTrigger_Test
 * Description : Test class for an Apex trigger CaseAlertCountTrigger 
 * Created By  : Silviu Frantescu
 * Created On  : 10-18-2013
*/

@isTest
private class CaseAlertCountTrigger_Test{
    static case cas;
    static Case_Alert__c alert;
    static RecordType recType = [Select Id From RecordType  Where SobjectType = 'Case_Alert__c' and DeveloperName = 'Collaborative'];
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas;
        alert = new Case_Alert__c();
        alert.name = 'test alert';
        alert.Case__c = cas.id;
        alert.Priority__c = 'High';
        alert.Status__c = 'Open';
        insert alert;
    }
    private static testmethod void testCountMethod(){
        Test.startTest();
        testData();
        alert.RecordTypeId = recType.id;
        update alert;
        Test.stopTest();        
        system.assertEquals(alert.Priority__c, 'High');
    }
}