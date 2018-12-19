/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: UpdateCommunityReferralObject_Test
** Description: To test the invocable method on UpdateCommunityReferralObject
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Sanjoy                     11/11/2018                          Created
********************************************************************************************/
@isTest
private class UpdateCommunityReferralObject_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Referral__c referral_Obj = new Referral__c(Has_legal_authority__c = false, Is_the_Individual_Attending_School_Indic__c = false, Is_the_Individual_eligible_for_CLBC_Serv__c = false, Is_the_individual_being_supported_by_CFD__c = false, Mailing_Address_same_as_Physical_Address__c = true, Physical_Address_Postal_Code__c = 'V1V1V1', Primary_Contact_Is_Individual_Indicator__c = false, Receiving_Services_on_Reserve__c = false, Foundry_BC_Referral__c = false);
    Insert referral_Obj; 
    test.stopTest();
  }
  static testMethod void test_updateCommunityReferral_UseCase1(){
    List<Referral__c> referral_Obj  =  [SELECT Id,Physical_Address_Postal_Code__c,Community__c from Referral__c];
    System.assertEquals(true,referral_Obj.size()>0);
    UpdateCommunityReferralObject obj01 = new UpdateCommunityReferralObject();
    UpdateCommunityReferralObject.updateCommunityReferral(new List<Id>());
    System.assertEquals(referral_Obj[0].Community__c,'Unknown');
  }
}