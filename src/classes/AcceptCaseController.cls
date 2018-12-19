/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Accept Case button
** Description: Accept case button, where the referral record gets converted to 
**person account, case and related contacts
** Version: 1.0     
    
* Reju Palathingal           06/09/2013         Created the controller for accept case button
*                                         creating the person account, contats and Case records.
* ----------------------------------------------------------------------------------------------
* Modification Log:
* ----------------------------------------------------------------------------------------------
* Developer                      Date                    Description     
** ---------                      ----                    -----------   
* @Gaurav Verma                  18/09/2013              Changing the Referral Status.
*                                                        Validating if Docs are Attached
* @Gaurav Verma                  19/09/2013              Mapping Notes(Ref) to Description(Case)
*                                                        Inserting all the referal contact to contact
*
* @Reju                          16/10/2013              Removed the referral contacts mapping o contacts, as part of sprint3
* ----------------------------------------------------------------------------------------------
*/
public class AcceptCaseController {  
  Public Referral__c record {get; set;}
  Public list<Case> caseReclist {get; set;}
  public Id id{get;set;}
  public Id did{get;set;}
  Public list <Case_Document__c> casdoc{get; set;}
  public id accrecid{get; set;}
  public id casdocrecid{get; set;}

    public AcceptCaseController(ApexPages.StandardController controller) {
        record = (Referral__c)controller.getRecord();//Holding lastname
        caseReclist = new list<Case>();//Initializing the list        
        id=  ApexPages.currentPage().getParameters().get('id');

    }
    public Case cas {
        get{
          if(cas== null) cas= new Case();
          return cas;
        }
        set;
    }
    
    //Logic for press of Accept Button
    public pagereference AcceptCase(){
        Id recordId = System.currentPagereference().getParameters().get('Id');
        List<Referral__c> lstref =[Select Id,OwnerId, Individual__c, Eligibility_Type__c, Individual_First_Name__c, Individual_Last_Name__c,Individual_Middle_Name__c,Community__c, Physical_Address_Line_1__c, Physical_Address_Line_2__c, Physical_Address_City__c,Physical_Address_Postal_Code__c, Physical_Address_Province__c, Mailing_Address_same_as_Physical_Address__c, Mailing_Address_Line_1__c, Mailing_Address_Line_2__c, Mailing_Address_City__c, Mailing_Address_Province__c, Mailing_Address_Postal_Code__c,Individual_Date_of_Birth__c, Individual_Gender__c, Individual_Email_Address__c, Individual_Work_Phone_Number__c, Individual_Home_Phone_Number__c, Receiving_Services_on_Reserve__c,
        Individual_Cell_Phone_Number__c,Case__c,EIS_Location__c, EIS_Region__c, Individual_Preferred_Name__c, Existing_Protocols_Safeguards__c, Other_Agencies_Involved__c, Language_in_the_Home__c,Other_Language__c,DAA_or_other_cultural_or_spiritual_repre__c, Special_limitations_hearing_sight_mob__c, What_services_they_are_waiting_for__c, Has_legal_authority__c,Primary_Contact_Is_Individual_Indicator__c, CreatedDate, Is_the_Individual_Attending_School_Indic__c,Is_the_individual_being_supported_by_CFD__c, Is_the_Individual_eligible_for_CLBC_Serv__c,Type_of_Referral__c, Referral_Notes__c, Referring_Organization__c, CreatedBy.id,Current_School__c from Referral__c where id =:recordId Limit 1];
  		if( lstref.size()>0 && lstref[0].Community__c == null)
           {
           	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please make sure that the Community field is populated before accepting the case. This is done by pressing the “Match Community” button on the Referral.'));
            return null;
           }
  
        List<Case_Contact__c> refcon = [Select Id,Contact_Type__c, Case__c, Organization_Name__c, Contact_Subtype__c,Relationship_Subtype__c,Contact_Person_First_Name__c,Contact_Person_Last_Name__c, Contact_Person_Profession_Role__c, Contact_Person_Cell_Phone_Number__c,Contact_Person_Home_Phone_Number__c,Contact_Person_Work_Phone_Number__c,Contact_Person_Email_Address__c  from Case_Contact__c where Referral__r.Id =:recordId];     
        List<Attachment> attach= [Select Id, Name, BodyLength, Body, Description, ParentId From Attachment where Parentid =:recordId];
        if(lstref.size()>0)
        {
            String own = lstref[0].OwnerId;
        	if (own.startsWith('00G')) 
            {
                 ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, 'Please make sure the referral has been assigned to a navigator before accepting/rejecting it; only navigators who own the referral can accept/reject'));
                 return null;
            }
        }
        Profile PR = [select Name from Profile where id =:userinfo.getProfileId()];
        if (PR.Name == 'STADD Navigator' )
        {
            ID id1 = userinfo.getUserId();
            if(lstref.size()>0 && id1 != lstref[0].OwnerId)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please make sure the referral has been assigned to a navigator before accepting/rejecting it; only navigators who own the referral can accept/reject'));
                return null;
            }
        }        
           
           if (lstref.size()>0 && lstref[0].Eligibility_Type__c == null)
           {
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You must assign an eligibility type before creating the case'));
                return null;
           }
                
        if(lstref.size()>0){
            // Start of change Gaurav : Validating if Docs are Attached
            Referral__c Ref1 = new Referral__c();
            Ref1 = lstref[0];
            List<Case_Document__c> Docs1 = [Select Id, Case__c, Referral__c, Category__c,Sub_Category__c from Case_Document__c where Referral__c =:Ref1.Id ];
            Integer i = 0;
            Integer j = 0;
            if(Docs1.size() >= 2 ) // modified for Defect D-00296
            {  
                for(Case_Document__c Doc:Docs1)
                {
                        if (Doc.Category__c == 'Individual' && Doc.Sub_Category__c == 'Consent') // modified for Defect D-00296
                        i ++;
                        if (doc.Category__c == 'Assessment' && Doc.Sub_Category__c == 'Diagnosis Proof') // modified for Defect D-00296
                        j ++;
                }
                
            }
            if (Docs1.size() < 2 || i < 1 || j < 1) // modified for Defect D-00296
            {
                  String Msg1 = System.Label.Accept_Case_1;
                  ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, Msg1));
                  Return Null;
            }
            
            
            // End of change Gaurav
            Case cas =new Case();
        
            Account perAcc= new Account();
            //Case_Document__c casdoc1 = new Case_Document__c();
            //Case_Document__c casdoc2 = new Case_Document__c();
            perAcc.LastName = lstref.get(0).Individual_Last_Name__c;
            perAcc.Contact_Middle_Name__pc = lstref.get(0).Individual_Middle_Name__c;
            perAcc.FirstName = lstref.get(0).Individual_First_Name__c;
            perAcc.PersonOtherStreet = lstref.get(0).Physical_Address_Line_1__c;
            List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Individual' and SobjectType ='Account' limit 1];// changed recordtype for defect 320
            perAcc.RecordTypeId = rectype.get(0).id;
            perAcc.PersonOtherCity = lstref.get(0).Physical_Address_City__c;
            perAcc.PersonOtherPostalCode = lstref.get(0).Physical_Address_Postal_Code__c;
            perAcc.PersonOtherState = lstref.get(0).Physical_Address_Province__c;
            perAcc.Mailing_Address_same_as_Physical_Address__c = lstref.get(0).Mailing_Address_same_as_Physical_Address__c;
            perAcc.Gender__c = lstref.get(0).Individual_Gender__c;
            perAcc.PersonBirthdate = lstref.get(0).Individual_Date_of_Birth__c;
            perAcc.Primary_Contact_Indicator__pc = lstref.get(0).Primary_Contact_Is_Individual_Indicator__c; // GV D-00134
            perAcc.PersonHomePhone =lstref.get(0).Individual_Home_Phone_Number__c;
            perAcc.PersonEmail = lstref.get(0).Individual_Email_Address__c;
            perAcc.PersonMailingStreet=lstref.get(0).Mailing_Address_Line_1__c;
            perAcc.PersonMailingCity =lstref.get(0).Mailing_Address_City__c;
            perAcc.PersonMailingState=lstref.get(0).Mailing_Address_Province__c;
            perAcc.PersonMailingPostalCode=lstref.get(0).Mailing_Address_Postal_Code__c;
            perAcc.Work_Phone__c=lstref.get(0).Individual_Work_Phone_Number__c;
            perAcc.Cell_Phone__c=lstref.get(0).Individual_Cell_Phone_Number__c;
            perAcc.Individual_Preferred_Name__pc = lstref.get(0).Individual_Preferred_Name__c; // Added for defect D-00347
            // Start of change for Defect 0060
            //perAcc.phone = lstref.get(0).Individual_Home_Phone_Number__c; /commented fordefect 150
            //perAcc.Mobile = lstref.get(0).Individual_Cell_Phone_Number__c;
            // End of change for Defect 0060
            
            //duplicate Case record Not allow (no more required)
    
            try {
                insert perAcc;
            } catch (System.DmlException e) {
                for (Integer n = 0; n < e.getNumDml(); n++) {
                    System.debug(e.getDmlMessage(n)); 
                }
            }
                
            List <Account> acc = [Select Id,PersonContactId from Account where Id =:perAcc.Id limit 1];
            cas.AccountId=perAcc.Id;
            List<RecordType> casrectype =[Select Id,Name From RecordType Where Name = 'Standard' and SobjectType ='Case' limit 1];
            cas.RecordTypeId = casrectype.get(0).id;
            cas.Status='New';
            cas.Type=lstref.get(0).Type_of_Referral__c;
            //System.debug('Value---'+perAcc.PersonContactId);
            //cas.ContactId= perAcc.PersonContactId;
            cas.Eligibility_Type__c = lstref.get(0).Eligibility_Type__c;
            If(!acc.isEmpty())
            cas.ContactID = acc[0].PersonContactId;
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please make sure the referral has the individual information before proceeding'));
                return null;
            
            }
            cas.Existing_Protocols_Safeguards__c =lstref.get(0).Existing_Protocols_Safeguards__c;
            cas.Other_Agencies_Involved__c =lstref.get(0).Other_Agencies_Involved__c;
            cas.Language_in_the_Home__c =lstref.get(0).Language_in_the_Home__c;
            cas.Other_Agencies_Involved__c =lstref.get(0).Other_Agencies_Involved__c;
            cas.DAA_or_other_cultural_or_spiritual_repre__c =lstref.get(0).DAA_or_other_cultural_or_spiritual_repre__c;
            cas.Has_a_legal_authority__c =lstref.get(0).Has_legal_authority__c;
            cas.Is_primary_contact__c =lstref.get(0).Primary_Contact_Is_Individual_Indicator__c;
            cas.Is_the_Individual_Attending_School__c =lstref.get(0).Is_the_Individual_Attending_School_Indic__c;
            cas.Is_the_Individual_eligible_for_CLBC_Serv__c =lstref.get(0).Is_the_Individual_eligible_for_CLBC_Serv__c;
            cas.Is_the_individual_being_supported_by_CFD__c =lstref.get(0).Is_the_individual_being_supported_by_CFD__c;
            cas.Special_limitations_hearing_sight_mob__c =lstref.get(0).Special_limitations_hearing_sight_mob__c;
            cas.What_services_they_are_waiting_for__c =lstref.get(0).What_services_they_are_waiting_for__c;
            cas.Date_Referred__c = lstref.get(0).CreatedDate.date(); // Detect D00024
            cas.Referring_Organization__c =lstref.get(0).Referring_Organization__c;
            cas.Language_in_the_Home_Other__c =lstref.get(0).Other_Language__c;
            cas.Name_of_Referrer__c = lstref.get(0).CreatedBy.id;
            cas.Date_referral_accepted__c=system.today();
            cas.Language_in_the_Home__c = lstref.get(0).Language_in_the_Home__c;
            cas.Language_in_the_Home_Other__c = lstref.get(0).Other_Language__c;
            cas.Region__c = lstref.get(0).EIS_Region__c;            
            cas.Location__c = lstref.get(0).EIS_Location__c;    
            cas.Subject = lstref.get(0).Individual_First_Name__c +' '+ lstref.get(0).Individual_Last_Name__c;
            cas.Origin  = lstref.get(0).Type_of_Referral__c; // add for Defect 333
            cas.Referral__c = lstref.get(0).id;
            cas.OwnerId = lstref.get(0).OwnerId; // Added for defect D-00344
            cas.Community__c = lstref.get(0).Community__c;
            //cas.Individual_Preferred_Name__c = lstref.get(0).Individual_Preferred_Name__c;
            cas.Description = lstref.get(0).Referral_Notes__c;  // Mapping Notes to Description by Gaurav
            cas.Receiving_Services_on_Reserve__c = lstref.get(0).Receiving_Services_on_Reserve__c; //Balaji added to transferred over to the case when it is created
            cas.Current_School__c = lstref.get(0).Current_School__c; //Remedy # 654561
            try {
                insert cas;
            } catch (System.DmlException e) {
                for (Integer n = 0; n < e.getNumDml(); n++) {
                    System.debug(e.getDmlMessage(n)); 
                }
            }       
            // Start of change Gaurav : Changing the Referral Status.
            Referral__c G = new Referral__c();
            G = lstref[0];
            G.Status__c = 'Case Created';
            G.Sub_Status__c = 'Converted to Case';
            G.Case__c = cas.id;
            G.Individual__c = perAcc.Id;
            try {
                Update G;
            } catch (System.DmlException e) {
                for (Integer n = 0; n < e.getNumDml(); n++) {
                    System.debug(e.getDmlMessage(n)); 
                }
            }
            List<Case_Document__c> Docs = [Select Id, Case__c, Referral__c from Case_Document__c where Referral__c =:G.Id ];
            for(Case_Document__c Doc:Docs)
              {
                Doc.Case__c = cas.id;
              }
                try {
                    Update Docs;
                } catch (System.DmlException e) {
                    for (Integer n = 0; n < e.getNumDml(); n++) {
                        System.debug(e.getDmlMessage(n)); 
                    }
                }         
              
                List<Case_Note__c> Notes = [Select Id, Case__c, Referral__c from Case_Note__c where Referral__c =:G.Id ];
                for(Case_Note__c Note:Notes)
                  {
                    Note.Case__c = cas.id;
                  }
                    try {
                        Update Notes;
                    } catch (System.DmlException e) {
                        for (Integer n = 0; n < e.getNumDml(); n++) {
                            System.debug(e.getDmlMessage(n)); 
                        }
                    }
                // End of change Gaurav    
            
            // Start of change by Gaurav Commenting old code
            List<Case_Contact__c> lstrefContact = new List<Case_Contact__c>();
            if(refcon.size()>0)
            { 
                
                for(Case_Contact__c C1:refcon)
                {

                            C1.Case__c = cas.id;
                            lstrefContact.add(C1);

                }
                try {
                        Update lstrefContact;
                        //update cas;
                    } catch (System.DmlException e) {
                        for (Integer n = 0; n < e.getNumDml(); n++) {
                            System.debug(e.getDmlMessage(n)); 
                        }
                    }                          
             }
             //if Primary not checkd setting the Primary lookup for Case with Primary
             //List<Case> updlstcase =  new List<Case>();
                if ( lstref[0].Primary_Contact_Is_Individual_Indicator__c != True)
                {
                    for(Case_Contact__c C:refcon)
                    {
                        if ( C.Relationship_Subtype__c != NULL && C.Contact_Type__c == 'Primary')
                        {
                            cas.Primary_Referral_Contact__c = C.id;
                            //cas.Individual_Relationship__c = C.Relationship_Subtype__c;                                                           
                        }
                        try {
                                Update cas;
                            } catch (System.DmlException e) {
                                for (Integer n = 0; n < e.getNumDml(); n++) {
                                    System.debug(e.getDmlMessage(n)); 
                                }
                            }   
                     }
                                        
                }
                //added sharing for defect 296 part2
        Referral__Share referralShr = new Referral__Share ();
        referralShr.ParentId = lstref.get(0).id;
        referralShr.UserOrGroupId = userinfo.getuserID();
        referralShr.AccessLevel = 'Read';
        referralShr.RowCause = Schema.Referral__Share.RowCause.Self_Sharing__c;
        insert(referralShr);           
                //end of defect 296
                
        PageReference casPage = new PageReference('/' + cas.Id);
        casPage.setRedirect(true);
        return casPage;
        }
    else{
        
        return null;
        }   
        
    }
}