@isTest
private class ContactSharingForComm_Test {

    static testMethod void myUnitTest() {
        /*Account perAcc = new Account();   
        perAcc.LastName ='FN Test';
        perAcc.firstName ='LN Test';
        perAcc.Type_custom__c = 'Private Contact';      
        perAcc.PersonBirthdate = system.today();
        perAcc.Gender__c = 'Male';
        perAcc.Work_Phone__c = '9999999999';
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];// changed recordtype for defect 320
        perAcc.RecordTypeId = rectype.get(0).id;
        insert perAcc;
        
        Contact con = new Contact();
        con.LastName = 'test con';
        Account acc = [Select Id,Name From Account Where Id = '001f0000008njOJ'];
        con.AccountId = acc.id;
        //con.AccountId = perAcc.id;
        insert con;
        
        
        Profile profiles = [Select p.name, p.id From Profile p where p.Name like 'Partner Community Login User'];
        
        User usr = new User(alias = 'standt', email='testcasdoc@test.com', emailencodingkey='UTF-8', 
									lastname='test', firstname='test', languagelocalekey='en_US', 
									localesidkey='en_CA', profileid = profiles.id,
									timezonesidkey='America/Los_Angeles', ContactId = '003f0000009Dwea', username='testcasdoc@test.com');
		insert usr;
		*/
        Case cas = new case();
        cas.Status = 'New';
        //cas.OwnerId = usr.id;        
        insert cas;
        
        //system.runAs(usr){
        test.starttest();
        
  		pagereference pageref = Page.ContactSharingForCommPage; 
  		test.setCurrentPageReference(pageref);
  		ApexPages.currentPage().getParameters().put('id',cas.id);        
        Apexpages.standardcontroller sc = new Apexpages.standardcontroller(cas);    
        ContactSharingForComm obj = new ContactSharingForComm (sc);
        system.assertNotEquals(cas.id, null);
        test.stoptest();
		//}
    }
}