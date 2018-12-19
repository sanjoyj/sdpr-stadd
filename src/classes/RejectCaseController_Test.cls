/* Class Name  : RejectCaseController_Test
 * Description : Test class for an Apex class RejectCaseController
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class RejectCaseController_Test{
    static Referral__c ref;
    static Apexpages.standardcontroller sc;
    static RejectCaseController obj;
    
    private static testmethod void testData(){       
        Case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas; 
        ref = new Referral__c();
        ref.Case__c = cas.id;
        ref.Status__c = 'Pending';
        ref.Individual_First_Name__c ='Test';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1231231';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='22222';
        ID id1 = userinfo.getUserId();
        insert ref;
      } 
        private static testmethod void rejectControllerTest(){ 
        testdata();
        test.starttest();
        sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id); 
        obj = new RejectCaseController(sc);
        obj.RejectCase();
        system.assertNotEquals(obj.record, null); 
        test.stoptest();       
    }
    
    private static testmethod void rejectControllerNegativeTest()	
    { 
	    Profile p = [SELECT Id FROM Profile WHERE Name='STADD Executive']; 
        User Usr = new User(Alias = 'standt', 
                            Email='standarduser@gov.bc.ca', 
        					EmailEncodingKey='UTF-8', 
                            LastName='Testing', 
                            LanguageLocaleKey='en_US', 
        					LocaleSidKey='en_US', 
                            ProfileId = p.Id, 
        					TimeZoneSidKey='America/Los_Angeles', 
                            UserName='standarduser@gov.bc.ca'); 
        insert Usr;
        testdata();
        QueueSObject q=[Select Queue.Id from QueueSObject where Queue.Name = 'Coastal Region'];
        ref.OwnerId = q.Queue.Id; 
        update ref;
        
        test.starttest();
    	
        PageReference pageRef = Page.RejectCase;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id); 
        RejectCaseController rej = new RejectCaseController(sc1);
        system.runAs(Usr)
        {     
       		Pagereference ref1 = rej.RejectCase();
            System.assertEquals(null,ref1);
        }
        test.stoptest();          
    }
}