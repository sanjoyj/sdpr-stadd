/* Class Name  : newCaseController_Test
 * Description : Test class for an Apex class newCaseController  
 * Created By  : Silviu Frantescu
 * Created On  : 09-30-2013
*/

@isTest
private class newCaseController_Test{
    static case cas;
    static Referral__c ref;
    static Mapping_object__c mapobj;
    static Mapping_object__c mapobj1;
    static Mapping_object__c mapobj2;
    static Case_contact__c refcon;
    
    private static testmethod void testdata(){
        cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';
        insert cas; 
        ref = new Referral__c();
        refcon = new Case_contact__c ();
        ref.Case__c = cas.id;
        ref.Status__c = 'Pending';
        ref.Individual_First_Name__c ='Test';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '1234567890';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='12th street';
        ref.Physical_Address_Postal_Code__c='V1V1V1';
        ref.Mailing_Address_Line_1__c='line1';
        ref.Mailing_Address_Line_2__c='Line2';
        ref.Mailing_Address_Postal_Code__c ='Code';
        ref.Mailing_Address_Province__c='Province';
        ref.Individual_Date_of_Birth__c= system.today();
        ref.Primary_Contact_Is_Individual_Indicator__c = true;
        ref.EIS_Region__c = 'Northern Region';
        ref.EIS_Location__c = 'Prince George / Haida Gwaii';
        insert ref;
        mapobj= new Mapping_object__c();
        mapobj.Functional_Domain_Type__c = 'ReferralPage2';
        mapobj.Context_prompt__c = 'Test';
        
        mapobj1= new Mapping_object__c();
        mapobj1.Functional_Domain_Type__c = 'ReferralPage1';
        mapobj1.Context_prompt__c = 'Test';       
        mapobj2= new Mapping_object__c();
        mapobj2.Functional_Domain_Type__c = 'ReferralPage3';
        mapobj2.Context_prompt__c = 'Test';
        insert mapobj;
        insert mapobj1;
        insert mapobj2;
        
        system.assertNotEquals(ref, null);
        
        /*refcon.Contact_Person_Last_Name__c = 'Test';
        refcon.Contact_Person_Last_Name__c = 'Test';
        refcon.Relationship_Subtype__c = 'Other';
        refcon.Contact_Person_Work_Phone_Number__c = '1234567890';
        refcon.Contact_Person_Home_Phone_Number__c = '1456789876';
        refcon.Contact_Person_Cell_Phone_Number__c = '6753289765';
        insert refcon;*/
         
    }
    private static testmethod void controllerTest(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }
     private static testmethod void controllerTestFirstName(){  
        test.starttest();
        testdata();
        ref.Individual_First_Name__c ='';
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }
     private static testmethod void controllerTestLastName(){  
        test.starttest();
        testdata();
        ref.Individual_Last_Name__c ='';
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }    
     private static testmethod void controllerTestAddr(){ 
        test.starttest();
        testdata();
        ref.Physical_Address_City__c='';
        ref.Physical_Address_Line_1__c ='';
        ref.Physical_Address_Postal_Code__c='';
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }    
     private static testmethod void controllerTestAddr1(){ 
        test.starttest();
        testdata();
        ref.Mailing_Address_Line_1__c='ad';
        ref.Mailing_Address_Line_2__c='';
        ref.Mailing_Address_Postal_Code__c ='';
        ref.Mailing_Address_Province__c='';
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }
     private static testmethod void controllerTestNoPhone(){ 
        test.starttest();
        testdata();
        ref.Individual_Work_Phone_Number__c='';
        ref.Individual_Cell_Phone_Number__c='';
        ref.Individual_Home_Phone_Number__c ='';
        ref.Individual_Email_Address__c='';
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }
    private static testmethod void controllerBirthdayTest(){  
        test.starttest();
        testdata();
        ref.Individual_Date_of_Birth__c= date.today().addyears(-99); 
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
     }     
       
       

    private static testmethod void controllerBirthdayTest1(){  
        test.starttest();
        testdata();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        ApexPages.currentPage().getParameters().put('id', ref.id);
        ApexPages.currentPage().getParameters().put('name', ref.id);
        newCaseController obj = new newCaseController(sc);
        obj.fetchId();
        obj.step1();
        obj.step2();
        obj.step3();
        obj.save();
        test.stoptest();
    }
             
     private static testmethod void controllerNotNullObjTest(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);        
        newCaseController.phoneError(ref);
        obj.ref.Primary_Contact_Is_Individual_Indicator__c = true;
        obj.ref.Has_legal_authority__c = true;
        obj.step3();
        test.stoptest();
     }
     private static testmethod void step3Test(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        ref.Individual_Home_Phone_Number__c = null;
        ref.Individual_Cell_Phone_Number__c = null;
        ref.Individual_Work_Phone_Number__c = null;
        newCaseController.phoneError(ref);
        newCaseController.mailAddressError(null);
        obj.ref.Primary_Contact_Is_Individual_Indicator__c = null;
        obj.refcon = new case_contact__c ();
        obj.refcon.Contact_Person_Last_Name__c = 'test';
        obj.refcon.Contact_Person_First_Name__c = 'test';
        obj.refcon.Contact_Person_Home_Phone_Number__c = '12345';
        obj.refcon.Contact_Person_Work_Phone_Number__c  = '3456';
        obj.refcon.Contact_Person_Cell_Phone_Number__c  = '98763';
        obj.refcon.Relationship_Subtype__c = 'test';
        obj.step3();
        test.stoptest();        
        system.assertNotEquals(obj.refcon, null);
     }
     
     private static testmethod void step3TestForFirstName(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        newCaseController.phoneError(ref);
        newCaseController.mailAddressError(null);
        obj.ref.Primary_Contact_Is_Individual_Indicator__c = false;
        obj.refcon = new case_contact__c ();
        obj.refcon.Contact_Person_Last_Name__c = 'test';
        obj.refcon.Contact_Person_First_Name__c = null;
        obj.refcon.Contact_Person_Home_Phone_Number__c = '12345';
        obj.refcon.Contact_Person_Work_Phone_Number__c  = '3456';
        obj.refcon.Contact_Person_Cell_Phone_Number__c  = '98763';
        obj.refcon.Relationship_Subtype__c = 'test';
        obj.step3();
        obj.refcon.Contact_Person_First_Name__c = 'test';
        obj.refcon.Relationship_Subtype__c = null;
        obj.step3();
        obj.refcon.Relationship_Subtype__c = 'test';
        obj.refcon.Contact_Person_Home_Phone_Number__c = null;
        obj.refcon.Contact_Person_Work_Phone_Number__c  = null;
        obj.refcon.Contact_Person_Cell_Phone_Number__c  = null;
        obj.step3();
        test.stoptest();        
        system.assertNotEquals(obj.refcon, null);
     }
     
     private static testmethod void step3TestForLastName(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        ref.Individual_Home_Phone_Number__c = null;
        ref.Individual_Cell_Phone_Number__c = null;
        ref.Individual_Work_Phone_Number__c = null;
        newCaseController.phoneError(ref);
        newCaseController.mailAddressError(null);
        obj.ref.Primary_Contact_Is_Individual_Indicator__c = null;
        obj.refcon = new case_contact__c ();
        obj.refcon.Contact_Person_Last_Name__c = '';
        obj.refcon.Contact_Person_First_Name__c = 'test';
        obj.refcon.Contact_Person_Home_Phone_Number__c = '12345';
        obj.refcon.Contact_Person_Work_Phone_Number__c  = '3456';
        obj.refcon.Contact_Person_Cell_Phone_Number__c  = '98763';
        obj.refcon.Relationship_Subtype__c = 'test';
        obj.step3();
        test.stoptest();        
        system.assertNotEquals(obj.refcon, null);
        system.assertNotEquals(obj.refcon, null);
     }     
     private static testmethod void step3TestForPhone(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        ref.Individual_Home_Phone_Number__c = null;
        ref.Individual_Cell_Phone_Number__c = null;
        ref.Individual_Work_Phone_Number__c = null;
        newCaseController.phoneError(ref);
        newCaseController.mailAddressError(null);
        obj.ref.Primary_Contact_Is_Individual_Indicator__c = null;
        obj.refcon = new case_contact__c ();
        obj.refcon.Contact_Person_Last_Name__c = '';
        obj.refcon.Contact_Person_First_Name__c = 'test';
        obj.refcon.Contact_Person_Home_Phone_Number__c = '';
        obj.refcon.Contact_Person_Work_Phone_Number__c  = '';
        obj.refcon.Contact_Person_Cell_Phone_Number__c  = '';
        obj.refcon.Relationship_Subtype__c = 'Other';
        obj.step3();
        test.stoptest();        
        system.assertNotEquals(obj.refcon, null);
        system.assertNotEquals(obj.refcon, null);
     }     
      private static testmethod void saveTest(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        obj.ref = new Referral__c();
        obj.ref.Case__c = cas.id;
        obj.ref.Status__c = 'Pending';
        obj.ref.Individual_First_Name__c ='Test';
        obj.ref.Individual_Last_Name__c ='User';
        obj.ref.Individual_Date_of_Birth__c = system.today();
        obj.ref.Individual_Home_Phone_Number__c = '1231231';
        obj.ref.Physical_Address_City__c='City';
        obj.ref.Physical_Address_Line_1__c ='12th street';
        obj.ref.Physical_Address_Postal_Code__c='22222';
        obj.ref.Is_the_Individual_Attending_School_Indic__c = true;
        obj.socon.Contact_Person_First_Name__c = 'test';
        obj.socon.Contact_Person_Last_Name__c = 'test';
        obj.ref.Is_the_individual_being_supported_by_CFD__c = true;
        obj.cfdcon.Contact_Person_First_Name__c = 'test';
        obj.cfdcon.Contact_Person_Last_Name__c = 'test';
        obj.ref.Is_the_Individual_eligible_for_CLBC_Serv__c = true;
        obj.clbccon.Contact_Person_First_Name__c = 'test';
        obj.clbccon.Contact_Person_Last_Name__c = 'test'; 
        obj.vDocument.Name = 'test'; 
        obj.vDocument.Body = Blob.valueof('test');
        obj.vDocument2.Name = 'test2'; 
        obj.vDocument2.Body = Blob.valueof('test');    
        obj.save();        
        test.stoptest();
        system.assertNotEquals(obj.vDocument, null);
        system.assertNotEquals(obj.vDocument2, null);
     }
     private static testmethod void controllerNullObjTest(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        newCaseController.phoneError(null);
        obj.ref.Individual_Home_Phone_Number__c = '123';
        obj.ref.Individual_Cell_Phone_Number__c = '1234';
        obj.ref.Individual_Work_Phone_Number__c = '345';
        newCaseController.phoneError(obj.ref);
        obj.ref.Mailing_Address_same_as_Physical_Address__c = true;
        obj.ref.Mailing_Address_Line_1__c = 'address1';
        obj.ref.Mailing_Address_City__c = 'address mailing';
        obj.ref.Mailing_Address_Postal_Code__c = '12345';
        newCaseController.mailAddressError(obj.ref);
        test.stoptest();
     }
     
     private static testmethod void methodsTest(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        obj.ref.Individual_Date_of_Birth__c = system.today().addYears(20);
        //obj.getRelationships();
        obj.refcon.Relationship_Subtype__c = 'Other';
        obj.ref.Individual_Date_of_Birth__c = system.today().addYears(-20);
        //obj.getRelationships();
        obj.refcon.Relationship_Subtype__c ='Parent';
        obj.addcontact();
        obj.updatefield();
        obj.updatefield1();
        obj.contactlist = new list<Case_Contact__c>();
        obj.contactlist.add(refcon);
        obj.addcontact();
        Case_Contact__c casCon2 = new Case_Contact__c();
        obj.contactlist.add(casCon2);
        obj.addcontact();
        obj.numberOfRowToRemove = 1;
        obj.removecontact();
        Case_Contact__c casCon3 = new Case_Contact__c();
        obj.contactlist.add(casCon3);
         obj.addcontact();
        Case_Contact__c casCon4 = new Case_Contact__c();
        obj.contactlist.add(casCon4);
        obj.addcontact();
        Case_Contact__c casCon5 = new Case_Contact__c();
        casCon5.Contact_Person_First_Name__c = 'fName';
        casCon5.Contact_Person_Last_Name__c = 'lName';
        casCon5.Relationship_Subtype__c = 'Other';
        casCon5.Other_Relationship__c ='person';
        obj.contactlist.add(casCon5);
        obj.addcontact();
        obj.vDocument.Name = 'test'; 
        obj.vDocument.Body = Blob.valueof('test');
        obj.vDocument2.Name = 'test2'; 
        obj.vDocument2.Body = Blob.valueof('test');    
        obj.save();
        obj.ref.Primary_Contact_Is_Individual_Indicator__c = true;
        obj.step3();
        test.stoptest();
     }
         
     private static testmethod void runAsTest(){  
        test.starttest();
        testdata();
        ApexPages.StandardController sc = new ApexPages.StandardController(ref);
        newCaseController obj = new newCaseController(sc);
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser@gov.bc.ca', EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', ProfileId = p.Id, TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testorg.com.testUser');         
        System.runAs(u) 
        {
          //  PageReference pg = obj.save();
        //    system.assertequals(pg , null);
        }
        test.stoptest();
     }
     
 }