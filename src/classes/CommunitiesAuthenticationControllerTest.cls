@IsTest global with sharing class CommunitiesAuthenticationControllerTest {
    @IsTest(SeeAllData=true) 
    global static void TestCommunitiesAuthenticationController (){
        CommunitiesAuthenticationController controller = new CommunitiesAuthenticationController ();
        controller.setStaddID();
    }
}