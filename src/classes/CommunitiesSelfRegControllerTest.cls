/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
@IsTest public with sharing class CommunitiesSelfRegControllerTest {
    @IsTest(SeeAllData=true) 
    public static void testCommunitiesSelfRegController() {
        Mapping_object__c mapobj = new Mapping_object__c();
        mapobj.Context_prompt__c ='Test';
        mapobj.Functional_Domain_Type__c = 'PortalUserRegistration';
        insert mapobj;
        CommunitiesSelfRegController controller = new CommunitiesSelfRegController();
        controller.request.First_Name__c ='Test';
        controller.request.Last_Name__c ='Connect';
        controller.request.Email__c ='test@test.com';
        controller.request.Contact_Phone_Number__c = '123456789';
        controller.submitRequest();
        controller.request.User_Credentials_OR_Role_Profession__c='Other';
        controller.request.Relationship_to_Individual_if_Other__c='';
        system.assertEquals(controller.submitRequest(), null);
    }    
}