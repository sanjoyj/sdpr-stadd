/* Class Name  : PartnerPortalUserController_Test
 * Description : Test class for an Apex class PartnerPortalUserController
 * Created By  : Silviu Frantescu
 * Created On  : 10-28-2013
*/

@isTest
private class PartnerPortalUserController_Test{
    static System_Access_Request__c accessReqObj;
    static System_Access_Request__c accessReqObj1;
    static System_Access_Request__c accessReqObj2;
    static System_Access_Request__c accessReqObj3;
    
    private static testmethod void testData(){
        case cas = new case ();
        cas.status = 'New';
        cas.Origin = 'Phone';        
        insert cas;
        Referral__c ref = new Referral__c();
        ref.Case__c = cas.id;
        ref.Status__c = 'Pending';
        ref.Individual_First_Name__c ='Test';
        ref.Individual_Last_Name__c ='User';
        ref.Individual_Date_of_Birth__c = system.today();
        ref.Individual_Home_Phone_Number__c = '999-999-9999';
        ref.Physical_Address_City__c='City';
        ref.Physical_Address_Line_1__c ='street 1222';
        ref.Physical_Address_Postal_Code__c='G1G1G1';
        insert ref;
        Case_Contact__c refCon = new Case_Contact__c();
        refCon.Referral__c = ref.id;
        refCon.Case__c = cas.id;
        refCon.Relationship_Subtype__c = 'test';
        insert refCon;
        accessReqObj = new System_Access_Request__c();
        accessReqObj.Last_Name__c = 'test name';
        accessReqObj.First_Name__c = 'test first name';
        accessReqObj.Case_Contact__c = refCon.Id;
        accessReqObj.SiteMinder_GUID__c = 'test12345';
        //accessReqObj.Email__c = 'test@test.com';
        insert accessReqObj;
    }
    private static testmethod void testConstructorWithNull(){
    	
        test.startTest();
        testData();
        apexpages.currentpage().getparameters().put('id', accessReqObj.Id); 
        Portal_User_Counter__c C = new Portal_User_Counter__c();
       	Portal_User_Org__c O = new Portal_User_Org__c();
       	C.PortalUserCount__c = 1;      	
       	o.Portal_User_Org__c = 'Test';
       	c.Name= 'counter';
       	o.Name = 'Test';
       	insert c;
       	insert o;
 
        PartnerPortalUserController obj = new PartnerPortalUserController();
        
        obj.checkForNewUser();
        obj.createPortaluser();
        obj.getCustomerPortalProfiles();
        obj.reset();
        test.stopTest();
    }
    private static testmethod void testConstructorWithoutNull(){
    	case cas1 = new case ();
        cas1.status = 'New';
        cas1.Origin = 'Phone';        
        insert cas1;
        Referral__c ref1 = new Referral__c();
        ref1.Case__c = cas1.id;
        ref1.Status__c = 'Pending';
        ref1.Individual_First_Name__c ='Test';
        ref1.Individual_Last_Name__c ='User';
        ref1.Individual_Date_of_Birth__c = system.today();
        ref1.Individual_Home_Phone_Number__c = '999-999-9999';
        ref1.Physical_Address_City__c='City';
        ref1.Physical_Address_Line_1__c ='street 1222';
        ref1.Physical_Address_Postal_Code__c='G1G1G1';
        insert ref1;
        Case_Contact__c refCon1 = new Case_Contact__c();
        refCon1.Referral__c = ref1.id;
        refCon1.Case__c = cas1.id;
        refCon1.Relationship_Subtype__c = 'test';
        insert refCon1;
        accessReqObj1 = new System_Access_Request__c();
        accessReqObj1.Last_Name__c = 'test name';
        accessReqObj1.First_Name__c = 'test first name';
        accessReqObj1.Case_Contact__c = refCon1.Id;
        accessReqObj1.SiteMinder_GUID__c = 'test12345';
        //accessReqObj.Email__c = 'test@test.com';
        insert accessReqObj1;
        test.startTest();
        //testData();
        accessReqObj1.Email__c = 'test1@test.com';
        update accessReqObj1;
        apexpages.currentpage().getparameters().put('id', accessReqObj1.Id);         
        Portal_User_Counter__c C = new Portal_User_Counter__c();
       	Portal_User_Org__c O = new Portal_User_Org__c();
       	C.PortalUserCount__c = 2;
       	o.Portal_User_Org__c = 'Test2';
       	c.Name= 'counter';
       	o.Name = 'Test';
       	insert c;
       	insert o;
        PartnerPortalUserController obj = new PartnerPortalUserController();
        obj.sSelectedProfileId = [select id from Profile where name like '%Partner user%' limit 1].id;
        obj.checkForNewUser();
        obj.createPortaluser();
        test.stopTest();
    }
    private static testmethod void testConstructorNewUser(){
    	case cas2 = new case ();
        cas2.status = 'New';
        cas2.Origin = 'Phone';        
        insert cas2;
        Referral__c ref2 = new Referral__c();
        ref2.Case__c = cas2.id;
        ref2.Status__c = 'Pending';
        ref2.Individual_First_Name__c ='Test';
        ref2.Individual_Last_Name__c ='User';
        ref2.Individual_Date_of_Birth__c = system.today();
        ref2.Individual_Home_Phone_Number__c = '999-999-9999';
        ref2.Physical_Address_City__c='City';
        ref2.Physical_Address_Line_1__c ='street 1222';
        ref2.Physical_Address_Postal_Code__c='G1G1G1';
        insert ref2;
        Case_Contact__c refCon2 = new Case_Contact__c();
        refCon2.Referral__c = ref2.id;
        refCon2.Case__c = cas2.id;
        refCon2.Relationship_Subtype__c = 'test';
        insert refCon2;
        accessReqObj2 = new System_Access_Request__c();
        accessReqObj2.Last_Name__c = 'test name';
        accessReqObj2.First_Name__c = 'test first name';
        accessReqObj2.Case_Contact__c = refCon2.Id;
        accessReqObj2.SiteMinder_GUID__c = 'test12345';
        //accessReqObj.Email__c = 'test@test.com';
        insert accessReqObj2;
        test.startTest();
        //testData();
        accessReqObj2.Email__c = 'test@test.com.partner.user.test';
        update accessReqObj2;
        apexpages.currentpage().getparameters().put('id', accessReqObj2.Id);
        Portal_User_Counter__c C = new Portal_User_Counter__c();
       	Portal_User_Org__c O = new Portal_User_Org__c();
       	C.PortalUserCount__c = 3;
       	o.Portal_User_Org__c = 'Test3';
       	c.Name= 'counter';
       	o.Name = 'Test';
       	insert c;
       	insert o;    
        PartnerPortalUserController obj = new PartnerPortalUserController();        
        obj.sSelectedProfileId = [select id from Profile where name like '%Partner user%' limit 1].id;
        obj.checkForNewUser();
        obj.createPortaluser();
        test.stopTest();
    }
     private static testmethod void testExceptions(){
     	case cas3 = new case ();
        cas3.status = 'New';
        cas3.Origin = 'Phone';        
        insert cas3;
        Referral__c ref3 = new Referral__c();
        ref3.Case__c = cas3.id;
        ref3.Status__c = 'Pending';
        ref3.Individual_First_Name__c ='Test';
        ref3.Individual_Last_Name__c ='User';
        ref3.Individual_Date_of_Birth__c = system.today();
        ref3.Individual_Home_Phone_Number__c = '999-999-9999';
        ref3.Physical_Address_City__c='City';
        ref3.Physical_Address_Line_1__c ='street 1222';
        ref3.Physical_Address_Postal_Code__c='G1G1G1';
        insert ref3;
        Case_Contact__c refCon3 = new Case_Contact__c();
        refCon3.Referral__c = ref3.id;
        refCon3.Case__c = cas3.id;
        refCon3.Relationship_Subtype__c = 'test';
        insert refCon3;
        accessReqObj3 = new System_Access_Request__c();
        //accessReqObj3.Last_Name__c = 'test name';
        accessReqObj3.First_Name__c = 'test first name';
        accessReqObj3.Case_Contact__c = refCon3.Id;
        accessReqObj3.SiteMinder_GUID__c = 'test12345';
        //accessReqObj.Email__c = 'test@test.com';
        insert accessReqObj3;
        test.startTest();
        //testData();
        accessReqObj3.Last_Name__c = '';
        update accessReqObj3;
        
        apexpages.currentpage().getparameters().put('id', accessReqObj3.Id);
        Portal_User_Counter__c C = new Portal_User_Counter__c();
       	Portal_User_Org__c O = new Portal_User_Org__c();
       	C.PortalUserCount__c = 4;
       	o.Portal_User_Org__c = 'Test4';
       	c.Name= 'counter';
       	o.Name = 'Test';
       	insert c;
       	insert o;  
        PartnerPortalUserController obj = new PartnerPortalUserController();
        obj.bIsNewUserFound = true;
        obj.checkForNewUser();
        obj.createPortaluser();
        test.stopTest();
     }
    
}