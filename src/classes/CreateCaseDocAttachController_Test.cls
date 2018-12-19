@isTest
private class CreateCaseDocAttachController_Test {

    static testMethod void myUnitTest() {
       
        Account perAcc = new Account();
        perAcc.LastName ='FN Test';
        perAcc.firstName ='LN Test';
        perAcc.Type_custom__c = 'Private Contact';      
        perAcc.PersonBirthdate = system.today();
        perAcc.Gender__c = 'Male';
        perAcc.Work_Phone__c = '9999999999';
        List<RecordType> accrectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];// changed recordtype for defect 320
        perAcc.RecordTypeId = accrectype.get(0).id;
        insert perAcc;
        
        Case cas = new case();
        cas.Status = 'New';
        cas.AccountId = perAcc.id;
                
        insert cas;
 
        Referral__c ref = new Referral__c();           
        ref.Status__c = 'Case Created';
        ref.Individual_First_Name__c ='Individual';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1231231';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='22222';
        insert ref;
        
        Case_Document__c casdocument = new Case_Document__c();
        casdocument.Sub_Category__c = 'Legal';
        casdocument.Category__c = 'Individual';
        casdocument.Description__c = 'test';
        casdocument.Name = 'test';
       
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Document__c' limit 1];// changed recordtype for defect 320
        string recordtype= rectype.get(0).id;
        
        casdocument.RecordTypeId = recordtype;
        insert casdocument;
        
        Attachment att = new Attachment();
        att.ParentId = casdocument.id;
        att.Name = 'test doc';
        att.body = blob.valueOf('test body');
         
        insert att;
        
        test.starttest();
        
        pagereference pageref = Page.CreateCaseDocAttachPage; 
        test.setCurrentPageReference(pageref);
        ApexPages.currentPage().getParameters().put('id',casdocument.id); 
        ApexPages.currentPage().getParameters().put('RecordType',recordtype);
        ApexPages.currentPage().getParameters().put('retURL',cas.id);
        //string lkid= ApexPages.currentPage().getParameters().get(System.Label.Case_Lkid);
        //ApexPages.currentPage().getParameters().put(System.Label.Case_Lkid, lkid);
        
        Apexpages.standardcontroller sc = new Apexpages.standardcontroller(casdocument);    
        //CreateCaseDocAttachController obj = new CreateCaseDocAttachController (sc);
        //obj.Submit();
        system.assertNotEquals(casdocument.id, null);
        test.stoptest();
        
        
    }
    
    static testMethod void GoalTasktest() {
       
        Account perAcc = new Account();
        perAcc.LastName ='FN Test';
        perAcc.firstName ='LN Test';
        perAcc.Type_custom__c = 'Private Contact';      
        perAcc.PersonBirthdate = system.today();
        perAcc.Gender__c = 'Male';
        perAcc.Work_Phone__c = '9999999999';
        List<RecordType> accrectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];// changed recordtype for defect 320
        perAcc.RecordTypeId = accrectype.get(0).id;
        insert perAcc;
        
        Case cas = new case();
        cas.Status = 'New';
        cas.AccountId = perAcc.id;
                
        insert cas;
 
        Referral__c ref = new Referral__c();           
        ref.Status__c = 'Case Created';
        ref.Individual_First_Name__c ='Individual';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1231231';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='22222';
        insert ref;
        
        Case_Document__c casdocument = new Case_Document__c();
        casdocument.Sub_Category__c = 'Legal';
        casdocument.Category__c = 'Individual';
        casdocument.Description__c = 'test';
        casdocument.Name = 'test';
       
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Document__c' limit 1];// changed recordtype for defect 320
        string recordtype= rectype.get(0).id;
        
        casdocument.RecordTypeId = recordtype;
        insert casdocument;
        
        Attachment att = new Attachment();
        att.ParentId = casdocument.id;
        att.Name = 'test doc';
        att.body = blob.valueOf('test body');
         
        insert att;
        
        test.starttest();
        
        pagereference pageref = Page.CreateCaseDocAttachPage; 
        test.setCurrentPageReference(pageref);
        ApexPages.currentPage().getParameters().put('id',casdocument.id); 
        ApexPages.currentPage().getParameters().put('RecordType',recordtype);
        ApexPages.currentPage().getParameters().put('retURL','/stadd/apex/GoalTaskHomepage');
        //ApexPages.currentPage().getParameters().put(System.Label.Case_Lkid, 'CF00Nf0000000Pwl5_lkid');
        
        Apexpages.standardcontroller sc = new Apexpages.standardcontroller(casdocument);    
        //CreateCaseDocAttachController obj = new CreateCaseDocAttachController (sc);
        //obj.Submit();
        system.assertNotEquals(casdocument.id, null);
        test.stoptest();
    }
    
    static testMethod void GoalTasktestNew() {
       
        Account perAcc = new Account();
        perAcc.LastName ='FN Test';
        perAcc.firstName ='LN Test';
        perAcc.Type_custom__c = 'Private Contact';      
        perAcc.PersonBirthdate = system.today();
        perAcc.Gender__c = 'Male';
        perAcc.Work_Phone__c = '9999999999';
        List<RecordType> accrectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];// changed recordtype for defect 320
        perAcc.RecordTypeId = accrectype.get(0).id;
        insert perAcc;
        
        Case cas = new case();
        cas.Status = 'New';
        cas.AccountId = perAcc.id;
                
        insert cas;
 
        Referral__c ref = new Referral__c();           
        ref.Status__c = 'Case Created';
        ref.Individual_First_Name__c ='Individual';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1231231';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='22222';
        insert ref;
        
        Case_Document__c casdocument = new Case_Document__c();
        casdocument.Sub_Category__c = 'Legal';
        casdocument.Category__c = 'Individual';
        casdocument.Description__c = 'test';
        casdocument.Name = 'test';
       
        List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Document__c' limit 1];// changed recordtype for defect 320
        string recordtype= rectype.get(0).id;
        
        casdocument.RecordTypeId = recordtype;
        insert casdocument;
        
        Attachment att = new Attachment();
        att.ParentId = casdocument.id;
        att.Name = 'test doc';
        att.body = blob.valueOf('test body');
         
        insert att;
        
        test.starttest();
        
        pagereference pageref = Page.CreateCaseDocAttachPage; 
        test.setCurrentPageReference(pageref);
        ApexPages.currentPage().getParameters().put('id',casdocument.id); 
        ApexPages.currentPage().getParameters().put('RecordType',recordtype);
        ApexPages.currentPage().getParameters().put('retURL','/stadd/apex/GoalTaskHomepage');
        //ApexPages.currentPage().getParameters().put(System.Label.Case_Lkid, 'CF00Nf0000000Pwl5_lkid');
        
        Apexpages.standardcontroller sc = new Apexpages.standardcontroller(casdocument);    
        //CreateCaseDocAttachController obj = new CreateCaseDocAttachController (sc);
        //obj.Submit();
        system.assertNotEquals(casdocument.id, null);
        test.stoptest();
    }
    
}