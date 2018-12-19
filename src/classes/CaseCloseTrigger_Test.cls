/* Class Name  : CaseCloseTrigger_Test
 * Description : Test class for an Apex trigger CaseCloseTrigger
 * Created By  : Silviu Frantescu
 * Created On  : 10-29-2013
*/

@isTest
public class CaseCloseTrigger_Test{
    private static case cas;
    
    public static testmethod void testData(){
    	Profile profiles = [Select p.name, p.id From Profile p where p.Name like 'System Administrator'];
        
        User usr = new User(alias = 'standt', email='testcasealert@gov.bc.ca', emailencodingkey='UTF-8', 
									lastname='test', firstname='test', languagelocalekey='en_US', 
									localesidkey='en_CA', profileid = profiles.id,
									timezonesidkey='America/Los_Angeles', username='testcasealert@test.com');
		insert usr;
        cas = new case();
        cas.Status = 'New';
        cas.OwnerId = usr.id;
        insert cas;
        
        Case_Alert__c alert1 = new Case_Alert__c ();
        alert1.Name = 'test alert';
        alert1.Case__c = cas.id;
        alert1.Status__c = 'Open';
        alert1.Priority__c ='Normal';
        //List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Alert__c' limit 1];
        
        string AlertRecordID = Schema.SObjectType.Case_Alert__c.RecordTypeInfosByName.get('Restricted').RecordTypeId; 
        alert1.RecordTypeId = AlertRecordID;
        insert alert1;
        
        Plan__c plan = new Plan__c ();
        plan.Case__c = cas.Id;
        plan.Plan_Status__c = 'Draft in Progress';
        insert plan;
        Plan_Goal__c goal = new Plan_Goal__c ();
        goal.Plan__c = plan.Id;
        
        goal.Status__c = 'Active';
        insert goal;
        goal.Status__c = 'Future Planning';
        update goal;
        Plan_Milestone__c milestone = new Plan_Milestone__c ();
        milestone.Plan_Goal__c = goal.Id;
        milestone.Plan__c = plan.id;
        milestone.Status__c = 'Active';
        insert milestone;
        milestone.Status__c = 'Completed';
        update milestone;
        Action_Item__c actItem = new Action_Item__c ();
        actItem.Milestone__c = milestone.Id;
        actItem.Status__c ='Not Started';
        insert actItem;
        actItem.Status__c = 'Complete';
        update actItem;
        
        test.startTest();
        try{
            testData();
            cas.Status = 'Closed';
            update cas;
            update alert1;
            System.assert(false);
        }
        catch(Exception ex){
            //Expected
        }
        test.stopTest();
									
    }
    private static testmethod void testCloseCase(){
        
    }
    
    private static testmethod void testNotifyCaseAlert(){
    	Profile profiles = [Select p.name, p.id From Profile p where p.Name like 'System Administrator'];
        
        User usr = new User(alias = 'stand3', email='test1234@gov.bc.ca', emailencodingkey='UTF-8', 
                                    lastname='test', firstname='test', languagelocalekey='en_US', 
                                    localesidkey='en_CA', profileid = profiles.id,
                                    timezonesidkey='America/Los_Angeles', username='testcollalert2121@test.com');
        insert usr;
        Case casnew= new Case();
        casnew.Status = 'New';
        casnew.OwnerId = usr.Id;
        insert casnew;
        CaseTeamMember casteam = new CaseTeamMember();
        casteam.ParentId= casnew.id;
        casteam.MemberId =usr.id;
        List<CaseTeamRole> teamrole = [Select Id, Name, AccessLevel FROM CaseTeamRole limit 1];
        casteam.TeamRoleId = teamrole[0].id;      
        insert casteam;       
        Case_Alert__c alert = new Case_Alert__c ();
        //List<RecordType> rectype = [Select Id,Name From RecordType Where Name = 'Collaborative' and SobjectType ='Case_Alert__c' limit 1];
        //alert.RecordTypeId = rectype[0].id;
        string AlertRecordID = Schema.SObjectType.Case_Alert__c.RecordTypeInfosByName.get('Collaborative').RecordTypeId; 
        alert.RecordTypeId = AlertRecordID;
        alert.Case__c = casnew.id;
        alert.Status__c = 'Open';
        alert.Priority__c ='Normal';
        alert.Name = 'test';
        insert alert;
        
                
        /*Plan__c plan = new Plan__c ();
        plan.Case__c = casnew.Id;
        plan.Plan_Status__c = 'Draft in Progress';
        insert plan;
        Plan_Goal__c goal = new Plan_Goal__c ();
        goal.Plan__c = plan.Id;
        goal.Status__c = 'Active';
        insert goal;
        Plan_Milestone__c milestone = new Plan_Milestone__c ();
        milestone.Plan_Goal__c = goal.Id;
        milestone.Status__c = 'Active';
        insert milestone;
        Action_Item__c actItem = new Action_Item__c ();
        actItem.Milestone__c = milestone.Id;
        actItem.Status__c ='Not Started';
        insert actItem;*/
        
        
        test.startTest();
        
        try{
			casnew.Status = 'Closed';
            update casnew;
            update alert;
            System.assert(false);
        	}
        catch(Exception ex){
            //Expected
        }
        test.stopTest();
    }
    
    
    private static testmethod void SetActionitemAssignedTo(){
    	Profile profiles = [Select p.name, p.id From Profile p where p.Name like 'System Administrator'];
        
        User usr = new User(alias = 'standt', email='testAssignto@gov.bc.ca', emailencodingkey='UTF-8', 
									lastname='test', firstname='test', languagelocalekey='en_US', 
									localesidkey='en_CA', profileid = profiles.id,
									timezonesidkey='America/Los_Angeles', username='testcaseartassign@test.com');
		insert usr;
    	Case cas2= new Case();
        cas2.Status = 'New';
        cas2.OwnerId = usr.id;
        insert cas2;
        Case_Alert__c alert = new Case_Alert__c ();
        alert.Case__c = cas2.id;
        alert.Status__c = 'open';
        alert.Priority__c = 'Normal';
        alert.Name ='testalert3';
        string AlertRecordID = Schema.SObjectType.Case_Alert__c.RecordTypeInfosByName.get('Restricted').RecordTypeId; 
        alert.RecordTypeId = AlertRecordID;
        insert alert;
        Plan__c plan = new Plan__c ();
        plan.Case__c = cas2.Id;
        plan.Plan_Status__c = 'Draft in Progress';
        insert plan;
        Plan_Goal__c goal = new Plan_Goal__c ();
        goal.Plan__c = plan.Id;
        goal.Status__c = 'Active';
        insert goal;
        Plan_Milestone__c milestone = new Plan_Milestone__c ();
        milestone.Plan_Goal__c = goal.Id;
        milestone.Status__c = 'Active';
        milestone.Plan__c = plan.id;
        insert milestone;
        Action_Item__c actItem = new Action_Item__c ();
        actItem.Milestone__c = milestone.Id;
        actItem.Status__c ='Not Started';
        actItem.Activity__c = 'Test';
        actItem.Review_Date__c = system.today();
        actItem.Assign_To_Me__c = true;
        insert actItem;
        
        
        test.startTest();
        
        try{
			cas2.Status = 'Closed';
            update cas2;
            update alert;
            System.assert(false);
        	}
        catch(Exception ex){
            //Expected
        }
        test.stopTest();
    }
    
	private static testmethod void CaseAlertCount(){
    	Profile profiles = [Select p.name, p.id From Profile p where p.Name like 'System Administrator'];
        
        User usr = new User(alias = 'standt', email='testAssigncount@gov.bc.ca', emailencodingkey='UTF-8', 
									lastname='test', firstname='test', languagelocalekey='en_US', 
									localesidkey='en_CA', profileid = profiles.id,
									timezonesidkey='America/Los_Angeles', username='testcasealertcount@test.com');
		insert usr;
    	Case cas3= new Case();
        cas3.Status = 'New';
        cas3.OwnerId = usr.id;
        insert cas3;
        Case_Alert__c alert = new Case_Alert__c ();
        alert.Case__c = cas3.id;
        alert.Status__c = 'open';
        string AlertRecordID = Schema.SObjectType.Case_Alert__c.RecordTypeInfosByName.get('Restricted').RecordTypeId; 
        alert.RecordTypeId = AlertRecordID;
        alert.Priority__c = 'Normal';
        alert.Name ='testalert3';
        insert alert;
        
        Plan__c plan = new Plan__c ();
        plan.Case__c = cas3.Id;
        plan.Plan_Status__c = 'Draft in Progress';
        insert plan;
        Plan_Goal__c goal = new Plan_Goal__c ();
        goal.Plan__c = plan.Id;
        goal.Status__c = 'Active';
        insert goal;
        Plan_Milestone__c milestone = new Plan_Milestone__c ();
        milestone.Plan_Goal__c = goal.Id;
        milestone.Status__c = 'Active';
        milestone.Plan__c = plan.id;
        insert milestone;
        Action_Item__c actItem = new Action_Item__c ();
        actItem.Milestone__c = milestone.Id;
        actItem.Status__c ='Not Started';
        actItem.Activity__c = 'Test';
        actItem.Review_Date__c = system.today();
        actItem.Assign_To_Me__c = true;
        insert actItem;
        
        
        test.startTest();
        
        try{
			cas3.Status = 'Closed';
            update cas3;
            update alert;
            System.assert(false);
        	}
        catch(Exception ex){
            //Expected
        }
        test.stopTest();
    }
}