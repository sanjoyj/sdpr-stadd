@isTest
public class CaseSupportServiceTrigger_Test {
	
  static case cas;
    static Referral__c ref;
    static Case_Contact__c refCon;
    static Apexpages.standardcontroller sc;
    static AcceptCaseController obj;
    
    private static testmethod void testData(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name='STADD Navigator']; 
        User Usr = new User(Alias = 'standt1', Email='standarduser@gov.bc.ca', 
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
		
		Support_and_Service__c SS = new Support_and_Service__c();
		ss.Service_Support_Type__c = 'Test Class Rec';
		ss.Provider__c = 'test';
		ss.Service_Start_Date__c = system.today();
		ss.Case__c = cas.id;
		insert SS;

		Supplies_and_Equipment__c se = new Supplies_and_Equipment__c();
		se.Service_and_Support_Type__c = 'test class rec';
		se.Provider__c = 'Testing';
		se.Start_Date__c = system.today();
		se.Case__c = cas.id;
		insert se;
		
        Case_Document__c casdoc1 = new Case_Document__c();
        casdoc1.Referral__c =ref.id;
        //casdoc1.Case__c = cas.id;
        casdoc1.Category__c = 'Individual';
        casdoc1.Sub_Category__c = 'Consent';
        insert casdoc1;
        
        Functional__c FD = new Functional__c();
        fd.Functional_Domain_Type__c = 'Health Status';
        fd.Assessor_First_Name__c = 'test';
        fd.Assessor_Last_Name__c = 'test class rec';
        fd.Summary__c = 'testing';
        fd.Case__c = cas.id;
        insert fd;
        
        Functional_Domain_Update__c FuncDU = new Functional_Domain_Update__c();
        FuncDU.Update__c = 'Testing';
        FuncDU.Functional_Domain__c = fd.id;
        insert FuncDU;
        
        Case_Document__c casdoc2 = new Case_Document__c();
        casdoc2.Referral__c =ref.id;
        //casdoc2.Case__c = cas.id;
        casdoc2.Category__c = 'Assessment'; 
        casdoc2.Sub_Category__c = 'Diagnosis Proof';    
        insert casdoc2;  
              
        ref.Case__c = cas.id;
        update ref;
        
        system.runAs(Usr){ 
        

        ApexPages.currentPage().getParameters().put('id', ref.id);
        sc = new Apexpages.standardcontroller(ref);    
        obj = new AcceptCaseController (sc);
        obj.AcceptCase();
        }
    }
    private static testmethod void acceptCaseTest(){
        test.starttest();
        testData();      
        obj.Cas = null;
        obj.AcceptCase();
        
        system.assertNotEquals(obj.Cas, null);
        test.stoptest();
    }
    
    private static testmethod void acceptCaseDocsTest(){
        test.starttest();
        testData();  
      
        Case_Contact__c refCon2 = new Case_Contact__c(Referral__c = ref.id, Relationship_Subtype__c='test');
        insert refCon2;        
        Case_Note__c casNote = new Case_Note__c(Name='test case note', Referral__c=ref.id);
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

}