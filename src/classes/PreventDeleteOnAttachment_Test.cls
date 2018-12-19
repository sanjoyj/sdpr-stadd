/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 */
@isTest
private class PreventDeleteOnAttachment_Test{
  
    private static testmethod void testTriggerDelete(){
        test.startTest();
        
        case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas; 
        
        Attachment attachment = new Attachment(Name='An attachment',parentid=cas.id,body=blob.valueof('b'));
        insert attachment;
             
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@gov.bc.ca', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com.testUser');         
        System.runAs(u) 
        {  
           Try
           {
           	 delete attachment;
           }
           Catch(exception ex)
           {
           		//system.assertNotEquals(attachment.adderror., null);
           }
        }    
        test.stopTest();    
    }

}