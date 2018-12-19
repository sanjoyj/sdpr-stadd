/* Class Name  : AcceptCaseController_Test
 * Description : Test class for an Apex class AcceptCaseController 
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class AcceptCaseController_Test{
    static case cas;
    static Referral__c ref;
    static Case_Contact__c refCon;
    static Apexpages.standardcontroller sc;
    static AcceptCaseController obj;

    private static testmethod void testData(){
        
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
        ref.Physical_Address_Postal_Code__c='V2X6M2';
        ref.Mailing_Address_Postal_Code__c='V1V1V1';
        ref.Eligibility_Type__c = 'DD';
        ref.Community__c = 'MAPLE RIDGE';
        insert ref;
        
        refCon = new Case_Contact__c();
        refCon.Referral__c = ref.id;
        refCon.Relationship_Subtype__c = 'test';
        insert refCon;
       
        /*cas = new case ();       
        cas.status = 'New';
        cas.AccountId = perAcc.Id;
        cas.Origin = 'Phone';
        cas.OwnerId =  Usr.Id;            
        insert cas;
        */
        Case_Document__c casdoc1 = new Case_Document__c();
        casdoc1.Referral__c =ref.id;
        //casdoc1.Case__c = cas.id;
        casdoc1.Category__c = 'Individual';
        casdoc1.Sub_Category__c = 'Consent';
        insert casdoc1;
        
        Case_Document__c casdoc2 = new Case_Document__c();
        casdoc2.Referral__c =ref.id;
        //casdoc2.Case__c = cas.id;
        casdoc2.Category__c = 'Assessment'; 
        casdoc2.Sub_Category__c = 'Diagnosis Proof';    
        insert casdoc2;  
        
        system.runAs(Usr){     
        ApexPages.currentPage().getParameters().put('id', ref.id);
        sc = new Apexpages.standardcontroller(ref);    
		obj= new AcceptCaseController(sc);
        }
              
        //ref.Case__c = cas.id;
        //update ref;
      }
    private static testmethod void acceptCaseTest(){
        test.starttest();
        testData();       
        obj.AcceptCase();
        List<Case> createdCase =[select id,OwnerId from Case];
        system.assertEquals(1, createdCase.size());
        test.stoptest();
        
    }
    private static testmethod void acceptCaseDocsTest(){
        test.starttest();
        testData();    
        Case_Contact__c refCon2 = new Case_Contact__c(Referral__c = ref.id, Relationship_Subtype__c='test');
        insert refCon2;        
        Case_Note__c casNote = new Case_Note__c(Name='test',Referral__c=ref.id);
        insert casNote;
        obj.AcceptCase();
        test.stoptest();            
        system.assertEquals(obj.casdoc, null);        
    }
    
    private static testmethod void acceptCaseAccountDocsTest(){
        test.starttest();
        testData();
        List<RecordType> accrectype =[Select Id,Name From RecordType Where Name = 'Agency' and SobjectType ='Account' limit 1];
        Account acc = new Account(name='test account',RecordTypeId=accrectype.get(0).id);
        insert acc;
        obj.AcceptCase();        
        system.assertEquals(obj.casdoc, null);      
        test.stoptest();
    }
     private static testmethod void acceptCaseTest2(){
        test.starttest();
        testData(); 
        obj.AcceptCase();
        system.assertNotEquals(obj.Cas, null);
        test.stoptest();
    }
}