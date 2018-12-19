/* Class Name  : PartnerPortalUserController 
 * Description : This class is used to create partner community user and it provides access to community users for their respective cases.
 * Created By  : Silviu Frantescu
 * Created On  : 10-24-2013
*/

public class PartnerPortalUserController {
       public Contact con {get;set;}
       public User u {get;set;}
       public User newUser {get;set;}
       public Decimal counter {get; set;}
       public String Org {get; set;}
       public  System_Access_Request__c accessObj {get;set;}
       public String sSelectedProfileId {get;set;}
       public String sSystemRequestId {get;set;}
       public Boolean bIsNewUserFound {get;set;}
       public String role;
       Savepoint sp;
       //Constructor
       public PartnerPortalUserController () {
       		Portal_User_Counter__c C = Portal_User_Counter__c.getOrgDefaults();
       		Portal_User_Org__c O = Portal_User_Org__c.getOrgDefaults();
            counter = C.PortalUserCount__c + 1 ;
            Org = O.Portal_User_Org__c;
            
            sSystemRequestId = apexpages.currentpage().getparameters().get('id');
            accessObj = [select First_Name__c, Middle_Name_Initial__c, Last_Name__c, Email__c, Status__c, On_Behalf_Of__c, User_Credentials_OR_Role_Profession__c, Relationship_to_Individual_if_Other__c, EIS_Region__c,
                            Contact_Phone_Number__c, Professional_Identifying_Number__c, SiteMinder_GUID__c, Case_Contact__c, Case_Contact__r.Case__c from System_Access_Request__c where id = :sSystemRequestId];
            con = new Contact();
            u = new User();
            u.Username = Org+'Communityuser'+ integer.valueof(counter) +'@stadd.com';//accessObj.Email__c;
            newUser= new User();
            bIsNewUserFound = false;
            
        }
        
       public PageReference checkForNewUser(){
        try{
            System.debug('bIsNewUserFound: ' + bIsNewUserFound);
            if(bIsNewUserFound == true)
                return null;            
            System.debug('checking for new user with username:' + u.username);
            User usr = [select id, name, username from User where username= :u.username LIMIT 1];
            if(usr!=null && usr.username == u.username){
             newUser = usr;
             bIsNewUserFound = true;
             //counter= counter+1;
          }
          return null;
        }catch(Exception ex){
            System.debug('...didnt find user yet...');
            return null;
        }
       }    
       
       //Controller method invoked from the VF page button
       public PageReference createPortaluser()
	   {
			try
			{            
				//Create the Contact associated to the previously created Contact
				Id contactId = createContact(sSystemRequestId);            
				//Since the user is created asynchronously, we want to do some data validation to ensure the proper fields are populated
				if(sSelectedProfileId == null || u.username==null){
					if(sSelectedProfileId==null){
						ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Profile is required: Please select a profile to associate new user');
						ApexPages.addMessage(myMsg);
					}
					if(u.username==null){
					   ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Username is required: Please a username for the new user');
					   ApexPages.addMessage(myMsg);
					}
					return null;
				}
				//Create the User
				//createUser((String)contactId, con.Email, con.FirstName, con.lastname, u.Username, sSelectedProfileId, accessObj.SiteMinder_GUID__c);
				Database.DMLOptions dmo = new Database.DMLOptions();
				dmo.EmailHeader.triggerUserEmail = false;
				dmo.EmailHeader.triggerOtherEmail = false;             
				User u = new User(alias = 'standt', email=con.Email, FederationIdentifier = accessObj.SiteMinder_GUID__c, emailencodingkey='UTF-8', 
									lastname=con.lastname, firstname=con.FirstName, languagelocalekey='en_US', 
									localesidkey='en_CA', profileid = sSelectedProfileId, contactId=(String)contactId,
									timezonesidkey='America/Los_Angeles', username=u.Username, Federation_ID__c = accessObj.SiteMinder_GUID__c);            
				u.setOptions(dmo);
				//sp = Database.setSavepoint();
				insert u;
				
				Portal_User_Counter__c C = Portal_User_Counter__c.getOrgDefaults();
				Portal_User_Counter__c tempC =  new Portal_User_Counter__c( Id = C.id);
				tempC.PortalUserCount__c = counter;
				update tempc;
				//PortalUserCount = Counter.
				System_Access_Request__c accessObj1 = [select Id, Portal_Access_Granted__c  from System_Access_Request__c where id = :sSystemRequestId];
				accessObj1.Portal_Access_Granted__c = system.now();
				Update accessObj1;
				System.debug('User Record Inserted');
				counter= counter+1;
				role = accessObj.User_Credentials_OR_Role_Profession__c;
				if(ApexPages.currentPage() != null)
				{                
					system.debug('----accessObj.Case_Contact__c-----'+accessObj.Case_Contact__c);
					system.debug('----accessObj.Case_Contact__r.Case__c-----'+accessObj.Case_Contact__r.Case__c);
					system.debug('accessObj.SiteMinder_GUID__c'+accessObj.SiteMinder_GUID__c);
					if(accessObj.Case_Contact__r.Case__c != null)
					{                  
						system.debug('----before query-----'+accessObj.Case_Contact__c);
						// Start of change for Defect 176 & 288
						//CaseTeamRole teamRole = [Select Name, Id, AccessLevel From CaseTeamRole where name='Support Team'];
						List<CaseTeamRole> teamRoleList = [Select Name, Id, AccessLevel From CaseTeamRole where name =:role];
						//System.debug('Query1 result; CaseTeamMember Role role:::' + teamRoleList[0].Id + teamRoleList[0].name );
						System.debug('Query1 result; CaseTeamMember Role other:::' + teamRoleList.size());
						if(!teamRoleList.isEmpty()){
							System.debug('Query1 result; CaseTeamMember Role NAME:::' + teamRoleList[0].name );
						}
						if(teamRoleList.isEmpty())
						{
							teamRoleList = [Select Name, Id, AccessLevel From CaseTeamRole where name = 'Other'];
							System.debug('Query2 result; CaseTeamMember Role other:::' + teamRoleList.size());
							//System.debug('Query2 result; CaseTeamMember Role other:::' + teamRoleList[0].Id );
						}
						// End of change for Defect 176 & 288
						//system.debug('----after query-----'+teamRole);
						CaseTeamMember teamMem = new CaseTeamMember ();
						//teamMem.MemberId = '005f0000000iWJn';
						teamMem.MemberId = u.id;
						teamMem.ParentId = accessObj.Case_Contact__r.Case__c;
						//teamMem.TeamRoleId= teamRole.Id;
						if(!teamRoleList.isEmpty())
							teamMem.TeamRoleId = teamRoleList[0].Id;
						System.debug('CaseTeamMember Role:::' + teamMem.TeamRoleId );
						insert teamMem;
						System.debug('CaseTeamMember Record Inserted with Role:::' + teamMem.TeamRoleId );
	
					}
					if(accessObj.Case_Contact__c != null )
					{
						Case_Contact__c refCon = [select id, Contact__c from Case_Contact__c where id= :accessObj.Case_Contact__c];
						refCon.Contact__c = con.Id;
						update refCon;
						accessObj.Status__c = 'Active';
						
						update accessObj;
						
						//ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'successfully created Partner community user and linked it to its respective case 	record');
						//ApexPages.addMessage(myMsg);
					}
					//Select c.TeamTemplateMemberId, c.TeamRoleId,  c.ParentId, c.MemberId, c.Id, c.CreatedDate, c.CreatedById From CaseTeamMember c
					//ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Successfully created Portal Contact & User records.');
					//ApexPages.addMessage(myMsg);
					//PageReference newpage = new PageReference('/'+u.id);
					//return newpage;
					//isDisabled=true;
				}           
			}catch(Exception ex){
        	system.debug('****Exception****'+ex.getMessage() + ex.getStackTraceString () +  ex.getLineNumber() );
            //Display error message to VF page
            if(ApexPages.currentPage() != null){
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()); //+ ex.getStackTraceString () +  ex.getLineNumber() );
                ApexPages.addMessage(myMsg);
            }
            return null;
        }
        PageReference newpage = new PageReference('/'+sSystemRequestId);
        return newpage;
       }
    
    //Method to create the Contact
    public Id createContact(Id sysId){
        Account acc;
        list<Account> listacc = [select id, name from Account where name='All partner portal users'];
        if(listacc.size() > 0){
            acc = listacc[0];
        }
        else{
            acc = new Account ();
            acc.name = 'All partner portal users';
            insert acc;
            System.debug('Account Record Inserted with Name:::' + acc.name );
        }
        if(accessObj!= null){
				/*if(accessObj.First_Name__c == ''|| accessObj.First_Name__c == null ){
					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'First Name is required field.');
					ApexPages.addMessage(myMsg);
				}
				if(accessObj.Last_Name__c == ''|| accessObj.Last_Name__c == null ){
					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Last Name is a required field.');
					ApexPages.addMessage(myMsg);
				}
				if(accessObj.Email__c == ''|| accessObj.Email__c == null ){
					ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Email is a required field.');
					ApexPages.addMessage(myMsg);
				}*/
            con = new Contact();
            con.LastName = accessObj.Last_Name__c;
            con.FirstName = accessObj.First_Name__c;
            con.Contact_Middle_Name__c = accessObj.Middle_Name_Initial__c;
            con.FirstName = accessObj.First_Name__c;
            con.On_Behalf_Of__c = accessObj.On_Behalf_Of__c;
            con.Contact_Person_Profession_Role__c = accessObj.User_Credentials_OR_Role_Profession__c;
            con.Relationship_to_Individual_if_Other__c = accessObj.Relationship_to_Individual_if_Other__c;
            con.Phone = accessObj.Contact_Phone_Number__c;
            con.Professional_Identifying_Number__c = accessObj.Professional_Identifying_Number__c;                  
            con.Email = accessObj.Email__c;
            con.AccountId = acc.Id;
            con.Region__c = accessObj.EIS_Region__c; //Balaji; update the region field (on the access request) maps over to the newly created contact record
            insert con;
            System.debug('successfully created test contact with Id::::' + con.id);
            return con.id;
        }
        return null;
    }
    

    public List<SelectOption> getCustomerPortalProfiles() {
        //Execute query to get all profiles associated to Partner Community
        Profile[] profiles = [Select p.name, p.id From Profile p where p.UserLicense.Name like '%Partner Community%'];
        List<SelectOption> options = new List<SelectOption>();
        for(Profile p: profiles)
              options.add(new SelectOption(p.id,p.name));
        return options;
    }
    
    public PageReference reset(){
        PageReference newpage = new PageReference('/'+sSystemRequestId);
        //newpage.getParameters().clear();
        newpage.setRedirect(true);
        return newpage;
    }

}