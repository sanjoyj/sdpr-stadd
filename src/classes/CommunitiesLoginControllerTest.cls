/**
 * An apex page controller that exposes the site login functionality
 */
@IsTest global with sharing class CommunitiesLoginControllerTest {
    @IsTest(SeeAllData=true) 
    global static void testCommunitiesLoginController () {
        Login_Page_Messages__c lpm = new Login_Page_Messages__c();
            lpm.Display_Announcements__c=False;
        CommunitiesLoginController controller = new CommunitiesLoginController ();
       System.assertEquals(controller.dispAnnouncements,True);
        controller.forwardToAuthPage();
    }    
}