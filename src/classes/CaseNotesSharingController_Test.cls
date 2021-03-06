@isTest
private class CaseNotesSharingController_Test {

    static testMethod void myUnitTest() {
       /* Account perAcc = new Account();   
        perAcc.LastName ='FN Test';
        perAcc.firstName ='LN Test';
        perAcc.Type_custom__c = 'Private Contact';      
        perAcc.PersonBirthdate = system.today();
        perAcc.Gender__c = 'Male';
        perAcc.Work_Phone__c = '9999999999';
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];
        perAcc.RecordTypeId = rectype.get(0).id;
        insert perAcc;
        
        Contact con = new Contact();
        con.LastName = 'test con1';
        Account acc =[Select Id,Name From Account Where Id ='001f0000008njOJ' limit 1];
        con.AccountId = acc.id;
        //con.AccountId = perAcc.id;
        insert con;
        //Contact con =[Select Id,Name From Contact Where AccountId = '001f0000008njOJ' limit 1];
        
        Profile profiles = [Select p.name, p.id From Profile p where p.Name like 'Partner Community Login User'];
        
        User usr = new User(alias = 'standt', email='testcasdoc@test.com', emailencodingkey='UTF-8', 
									lastname='test', firstname='test', languagelocalekey='en_US', 
									localesidkey='en_CA', profileid = profiles.id,
									timezonesidkey='America/Los_Angeles', ContactId = '003f0000009Dwea', username='testcasdoc@test.com');
		insert usr;*/
		//system.runAs(usr){
        Case cas = new case();
        cas.Status = 'New';
        //cas.OwnerId = usr.id;        
        insert cas;
        
        
        Referral__c ref = new Referral__c();   
        //ref.OwnerId = usr.id;  
        ref.Status__c = 'Case Created';
        ref.Individual_First_Name__c ='Test';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1231231';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='22222';
        insert ref;
									
		Case_Note__c cascon = new Case_Note__c();
        cascon.Name = 'Test';
        List<RecordType> notetype =[Select Id,Name From RecordType Where Name = 'Collaborative' and SobjectType ='Case_Note__c' limit 1];
        cascon.RecordTypeId = notetype.get(0).id;
        
        cascon.Referral__c = ref.id;
        cascon.Case__c = cas.Id;
        insert cascon;
        
        test.starttest();
        
  		pagereference pageref = Page.CaseContactSharingPage; 
  		test.setCurrentPageReference(pageref);
  		ApexPages.currentPage().getParameters().put('id',cascon.id);        
        Apexpages.standardcontroller sc = new Apexpages.standardcontroller(cascon);    
        CaseNotesSharingController obj = new CaseNotesSharingController (sc);
        system.assertNotEquals(cascon.id, null);
        test.stoptest();
       // }
    }
}