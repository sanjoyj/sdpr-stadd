/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CaseNote_Test {
	static case cas;
    static Referral__c ref;
    static Case_Contact__c refCon;
    static Apexpages.standardcontroller sc;
    static AcceptCaseController obj;

    static testMethod void myUnitTest() {
        
		Profile p = [SELECT Id FROM Profile WHERE Name='STADD Navigator']; 
        User Usr = new User(Alias = 'standt', Email='standarduser@gov.bc.ca', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@gov.bc.ca'); 
        insert Usr;
                    
        Account perAcc = new Account();

		perAcc.LastName ='Test';
        
        //acc.Case__pc = cas.id;
        perAcc.PersonBirthdate = system.today();
        perAcc.Gender__c = 'Male';
        perAcc.Work_Phone__c = '9999999999';
        perAcc.Contact_Middle_Name__pc = 'Test';
        perAcc.FirstName = 'tester';
        perAcc.PersonOtherStreet = '123';
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];// changed recordtype for defect 320
        perAcc.RecordTypeId = rectype.get(0).id;
        perAcc.PersonOtherCity = 'City';
        perAcc.PersonOtherPostalCode = 'A1A1A1';
        perAcc.PersonOtherState = 'CA';
        perAcc.Mailing_Address_same_as_Physical_Address__c = true;
        perAcc.Primary_Contact_Indicator__pc = true; // GV D-00134
        perAcc.PersonHomePhone ='8888888888';
        perAcc.PersonEmail = 're@re.com';
        perAcc.PersonMailingStreet= '323';
        perAcc.PersonMailingCity ='city';
        perAcc.PersonMailingState= 'cs';
        perAcc.PersonMailingPostalCode='B2B2B2';
        perAcc.Work_Phone__c='7777777777';
        perAcc.Cell_Phone__c='6666666666';
        perAcc.Individual_Preferred_Name__pc = 'tete'; 
        insert perAcc;   
        
        ref = new Referral__c();   
        ref.OwnerId = Usr.id;  
        ref.Status__c = 'Case Created';
        ref.Individual_First_Name__c ='Test';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1231231';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='22222';
        ref.Eligibility_Type__c = 'DD';
        insert ref;
        
        refCon = new Case_Contact__c();
        refCon.Referral__c = ref.id;
        refCon.Relationship_Subtype__c = 'test';
        insert refCon;

		cas = new case ();       
        cas.status = 'New';
        cas.AccountId = perAcc.Id;
        cas.Origin = 'Phone';
        cas.OwnerId =  Usr.Id;            
        insert cas;
        
        Case_Document__c casdoc1 = new Case_Document__c();
        casdoc1.Referral__c =ref.id;
        //casdoc1.Case__c = cas.id;
        casdoc1.Category__c = 'Individual';
        casdoc1.Sub_Category__c = 'Consent';
        insert casdoc1;



    }
}