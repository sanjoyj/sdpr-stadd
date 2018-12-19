public with sharing class ContributionLogHelper {
//Note**********************************************************************************************//
	public static void CreateContributionFromNote(List<Id> plstCaseNoteId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Case_Note__c> lstCaseNote = [Select id,
												 Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												// Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										 from Case_Note__c where Id IN : plstCaseNoteId];
		
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Case_Note__c c:lstCaseNote)
		{
			lstContribution.add(CreateContribution(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContribution(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
//Plan Goal*********************************************************************************************//	
	public static void CreateContributionFromGoal(List<Id> plstPlanGoalId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>(); 
		List<Plan_Goal__c> lstPlanGoal = [Select id,
												// Recordtype.Name,
												 Plan__r.Case__c,
												 Plan__r.Case__r.Contact.Name,
												 Plan__r.Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												// Plan__r.Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 									from Plan_Goal__c where Id IN : plstPlanGoalId];
		
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Plan_Goal__c c:lstPlanGoal)
		{
			lstContribution.add(CreateContributionForPlan(c.Plan__r.Case__c, 
													strEventType, 
													strObjectType,
													c.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Plan__r.Recordtype.Name,													
													c.Plan__r.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}
	
		public static Contribution__c CreateContributionForPlan(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}

	//Plan_Milestone**************************************************************************************//
	public static void CreateContributionFromMilestone(List<Id> plstPlanMilestoneId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>(); 
		List<Plan_Milestone__c> lstPlanMilestone = [Select id,
												// Recordtype.Name,
												 Plan__r.Case__c,
												 Plan__r.Case__r.Contact.Name,
												 Plan__r.Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Plan__r.Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 									from Plan_Milestone__c where Id IN : plstPlanMilestoneId];
		 									
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Plan_Milestone__c c:lstPlanMilestone)
		{
			lstContribution.add(CreateContributionForPlan(c.Plan__r.Case__c, 
													strEventType, 
													strObjectType,
													c.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Plan__r.Recordtype.Name,													
													c.Plan__r.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}
	
	public static Contribution__c CreateContributionForPlan(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Action Item ***********************************************************************************************//
	
		public static void CreateContributionFromActionItem(List<Id> plstPlanActionItemId,String strObjectType,String strEventType)
	{
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		List<Contribution__c> lstContribution = new List<Contribution__c>(); 
		List<Action_Item__c> lstPlanActionItem = [Select id,
												// Recordtype.Name, 
												 Plan__r.Case__c,
												 Plan__r.Case__r.Contact.Name,
												 Plan__r.Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												// currentUserProfile.Name
		 									from Action_Item__c where Id IN : plstPlanActionItemId];
		
		for(Action_Item__c c:lstPlanActionItem)
		{
			lstContribution.add(CreateContributionForActionItem(c.id,
																c.Plan__r.Case__c, 
																strEventType, 
																strObjectType,
																c.CreatedBy.Contact.Region__c,
																c.CreatedBy.Contact.Organization1__c,
																strUserProfile,													
																//c.Plan__r.Recordtype.Name,													
																c.Plan__r.Case__r.Contact.Name ));
		}
		insert lstContribution; 
	}
	
	public static Contribution__c CreateContributionForActionItem(id pActionitemid,
														id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
					Con.Action_Item_Number__c = pActionitemid;
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Support and Services**********************************************************************************************//
	public static void CreateContributionFromSupportandservice(List<Id> plstServiceId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Support_and_Service__c> lstSupportandservice = [Select id,
												 //Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Support_and_Service__c where Id IN : plstServiceId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name; 
		
		for(Support_and_Service__c c:lstSupportandservice)
		{
			lstContribution.add(CreateContributionFromService(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromService(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Protocols and Safeguards**********************************************************************************************//
	public static void CreateContributionFromProtocolsandsafeguards(List<Id> plstProtocolId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Protocols_and_Safeguards__c> lstProtocolsandsafeguards = [Select id,
												 //Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Protocols_and_Safeguards__c where Id IN : plstProtocolId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Protocols_and_Safeguards__c c:lstProtocolsandsafeguards)
		{
			lstContribution.add(CreateContributionFromProtocol(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromProtocol(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Supplies and Equipments**********************************************************************************************//
	public static void CreateContributionFromSuppliesandEquipments(List<Id> plstSuppliesId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Supplies_and_Equipment__c> lstSuppliesandEquipments = [Select id,
												 //Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Supplies_and_Equipment__c where Id IN : plstSuppliesId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Supplies_and_Equipment__c c:lstSuppliesandEquipments)
		{
			lstContribution.add(CreateContributionFromSupplies(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromSupplies(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//List of Assessments**********************************************************************************************//
	public static void CreateContributionFromAssessments(List<Id> plstAssessmentId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Assessment_List__c> lstAssessments = [Select id,
												 //Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Assessment_List__c where Id IN : plstAssessmentId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Assessment_List__c c:lstAssessments)
		{
			lstContribution.add(CreateContributionFromAssessments(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromAssessments(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Case Alert**********************************************************************************************//
	public static void CreateContributionFromCaseAlert(List<Id> plstCaseAlertId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Case_Alert__c> lstCaseAlert = [Select id,
												 Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Case_Alert__c where Id IN : plstCaseAlertId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Case_Alert__c c:lstCaseAlert)
		{
			lstContribution.add(CreateContributionFromCaseAlert(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromCaseAlert(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Case Document**********************************************************************************************//
	public static void CreateContributionFromCaseDocuments(List<Id> plstCaseDocumentId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Case_Document__c> lstCaseDocument = [Select id,
												 Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Case_Document__c where Id IN : plstCaseDocumentId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Case_Document__c c:lstCaseDocument) 
		{
			lstContribution.add(CreateContributionFromCaseDocuments(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromCaseDocuments(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con; 
	}
	
	//Case Contact**********************************************************************************************//
	public static void CreateContributionFromCaseContact(List<Id> plstCaseContactId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Case_Contact__c> lstCaseContact = [Select id,
												 //Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Case_Contact__c where Id IN : plstCaseContactId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Case_Contact__c c:lstCaseContact)
		{
			lstContribution.add(CreateContributionFromCaseContact(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromCaseContact(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
	//Case Functional Domain Summaries**********************************************************************************************//
	public static void CreateContributionFromCaseFunctionalDomainSummaries(List<Id> plstCaseFunctionalDomainSummaryId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Functional__c> lstCaseFunctionalDomainSummary = [Select id,
												 //Recordtype.Name,
												 Case__c,
												 Case__r.Contact.Name,
												 Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Case__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Functional__c where Id IN : plstCaseFunctionalDomainSummaryId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Functional__c c:lstCaseFunctionalDomainSummary)
		{
			lstContribution.add(CreateContributionFromCaseFunctionalDomainSummaries(C.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromCaseFunctionalDomainSummaries(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}

//Case Functional Domain Update**********************************************************************************************//
	public static void CreateContributionFromCaseFunctionalDomainUpdate(List<Id> plstCaseFunctionalDomainUpdateId,String strObjectType,String strEventType)
	{
		List<Contribution__c> lstContribution = new List<Contribution__c>();
		List<Functional_Domain_Update__c> lstCaseFunctionalDomainUpdate = [Select id,
												 //Recordtype.Name,
												 Functional_Domain__r.Case__c,
												 Functional_Domain__r.Case__r.Contact.Name,
												 Functional_Domain__r.Case__r.Individual_Preferred_Name__c,
												 CreatedBy.Contact.Region__c,
												 CreatedBy.Contact.Organization1__c
												 //Functional_Domain__r.CreatedBy.Contact.Support_Team_Member_Role__c
		 										from Functional_Domain_Update__c where Id IN : plstCaseFunctionalDomainUpdateId];
		 										
		Profile currentUserProfile = [Select id,Name from Profile where ID =: Userinfo.getProfileId() LIMIT 1];
		String strUserProfile = currentUserProfile.Name;
		
		for(Functional_Domain_Update__c c:lstCaseFunctionalDomainUpdate)
		{
			lstContribution.add(CreateContributionFromCaseFunctionalDomainUpdate(C.Functional_Domain__r.Case__c, 
													strEventType, 
													strObjectType,
													C.CreatedBy.Contact.Region__c,
													c.CreatedBy.Contact.Organization1__c,
													strUserProfile,													
													//c.Recordtype.Name,													
													c.Functional_Domain__r.Case__r.Contact.Name ));
		}
		insert lstContribution;
	}


	public static Contribution__c CreateContributionFromCaseFunctionalDomainUpdate(id pCaseId, 
														String strEventType, 
														String strObjectType,
														String strRegion,
														String StrOrganization,
														String StrRole,
														//String StrRecordType,
														String StrIndividualName)
	{
		Contribution__c Con = new Contribution__c();
				Con.Case__c = pCaseId;
				Con.Action__c = strEventType;
				Con.Contribution_Type__c = strObjectType;
				if(String.isNotBlank(strRegion))
					Con.Region__c = strRegion;
				if(String.isNotBlank(StrOrganization))
					Con.Organization__c = StrOrganization;
				if(String.isNotBlank(StrRole))
					Con.User_Profile__c = StrRole;
				/*if (StrRecordType == 'Restricted')
					Con.Restricted_Indicator__c = true;
					else
					Con.Restricted_Indicator__c = false;*/
				if (String.isNotBlank(StrIndividualName))
					Con.Individual_Name__c = StrIndividualName;
			return Con;
	}
	
}