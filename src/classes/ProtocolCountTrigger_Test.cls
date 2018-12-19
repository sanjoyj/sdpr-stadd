/* Class Name  : ProtocolCountTrigger_Test
 * Description : Test class for an Apex trigger ProtocolCountTrigger
 * Created By  : Silviu Frantescu
 * Created On  : 10-18-2013
*/

@isTest
private class ProtocolCountTrigger_Test{

    static case cas;
    static Protocols_and_Safeguards__c protocol;
    private static testmethod void testData(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas;
        protocol = new Protocols_and_Safeguards__c();
        protocol.name = 'test protocol';
        protocol.Case__c = cas.id;
        protocol.Start_Date__c = system.today()-2;
        insert protocol;
    }
    private static testmethod void testCountMethod(){
        Test.startTest();
        testData();
        protocol.name = 'test protocol 2';
        update protocol;
        Test.stopTest();        
        system.assertEquals(protocol.name, 'test protocol 2');
    }

}