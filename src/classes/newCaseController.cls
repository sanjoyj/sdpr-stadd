/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: Referral Creation
** Description: Creation of the referral record and the referral contacts with the related attachments.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Reju Palathingal           3/9/2013         1.0                   Created** 
**Gaurav                     6/11/2013                          modified code
**Reju                       6/12/2013                          added code for defect D-00051
**Edmund                     5/21/2015                          Modified acronyms to have full name (Enhancement July 2015)
********************************************************************************************/

public class newCaseController  {

        public String erorr_Phone{get; set;}
        public String error_Mailadd{get; set;}
        public List<Case_Contact__c> contactlist{get;set;} 
        public List<Case_Contact__c> finalUpdateconlst{get; set;}
        public List<Case_Contact__c> errorupdlst{get; set;}
        public list<Case_Contact__c> addionalerrlist{get; set;}
        public Integer numberOfRowToRemove { get; set; }
        public Integer rowNumber {get; set;}
        public Mapping_object__c mapobj{get; set;}
                
        public boolean blnshow {get;set;}
        public boolean flg{get;set;}
        public boolean isButtonDisabled {get; set;}
        public boolean showhelptext{get; set;}
        public Integer row{get;set;}
        public Referral__c record {get; set;}

        public String RefName{get;set;}
        private Referral__c refdefault;
        public string sRelSubtypeSelected{get;set;}
        
        public Pagereference  updatefield(){
                system.debug('######gvgv' + blnshow);
                blnshow = true;
                return null;
                
        }
        public Pagereference  updatefield1(){
                system.debug('######gvgv' + blnshow);
                blnshow = false;
                return null;
        } 
        public Pagereference  safariflg(){
                system.debug('######gvgv' + flg);
                flg = true;
                return null;
        } 
               
        /*
        * Method name : isUSPhoneNumberFormat
        * Description : This method checks if the field value follows US phone number format
        * Return Type : String
        * Parameter : String
        */ 

    // not in use right now


        public newCaseController(ApexPages.StandardController controller) 
        {
                if(Apexpages.currentPage().getParameters().get('Id')!=null)
                RefName = Apexpages.currentPage().getParameters().get('Id');
                isButtonDisabled = false;
                contactlist =  new List<Case_Contact__c>();
                //contactlist =  new List<Case_Contact__c>();
                //flg = false;
                mapobj = [select id,Functional_Domain_Type__c,Context_prompt__c from Mapping_object__c where Functional_Domain_Type__c = 'ReferralPage1'
                                    LIMIT 1];  // added for defect 00051
        }

        public void fetchId()
        {
                if(Apexpages.currentPage().getParameters().get('Name')!=null)
                RefName = Apexpages.currentPage().getParameters().get('Name');
                System.debug('RefName'+RefName);
        }
        
        

        public Id docId{get; set;}

        public List<selectOption> getRelationships() {
        List<selectOption> options = new List<selectOption>();
        //if(ref.Individual_Date_of_Birth__c >= date.today().addyears(-19))
        if(!blnshow)
        {
                options.add(new selectOption('--None--', '--None--'));
                options.add(new selectOption('Other', 'Other'));
                options.add(new selectOption('Parent', 'Parent'));
                options.add(new selectOption('Parent', 'CFD (Children and Family Development)')); //enhancement July 2015
        }
        else
        {
                options.add(new selectOption('--None--', '--None--'));          
                //options.add(new selectOption('Family', 'Family'));
                options.add(new selectOption('Parent', 'Committee'));
                options.add(new selectOption('Parent', 'Representative'));
        }
        
        return options; //return the picklist options
    }

        public Referral__c ref 
        {
                get{
                        if(ref== null) ref= new Referral__c(Type_of_Referral__c = 'Organizational Referral', Mailing_Address_Province__c='', Physical_Address_Province__c='BC', What_services_they_are_waiting_for__c = 'None', Existing_Protocols_Safeguards__c='None', DAA_or_other_cultural_or_spiritual_repre__c='None', Other_Agencies_Involved__c='None', Special_limitations_hearing_sight_mob__c='None');
                return ref;
                }
                set;
        }        

        public Case_Contact__c refcon
        {
                get{
                if(refcon== null) refcon= new Case_Contact__c();
                return refcon;
                }
                set;
        }
        public Case_Contact__c socon
        {
                get{
                if(socon== null) socon= new Case_Contact__c();
                return socon;
                }
                set;
        }

        public Case_Contact__c cfdcon
        {
                get{
                if(cfdcon== null) cfdcon= new Case_Contact__c();
                return cfdcon;
                }
                set;
        }
        public Case_Contact__c clbccon
        {
                get{
                if(clbccon== null) clbccon= new Case_Contact__c();
                return clbccon;
                }
                set;
        }

        public Attachment vDocument 
        {
                get{
                if(vDocument== null) vDocument = new Attachment();
                return vDocument;
                }
                set;
        }
        public Attachment vDocument2 
        {
                get{
                if(vDocument2== null) vDocument2 = new Attachment();
                return vDocument2;
                }
                set;
        }
        public Case_Document__c casedoc 
        {
                get{
                if(casedoc== null) casedoc = new Case_Document__c();
                return casedoc;
                }
                set;
        }
        public Case_Document__c casedoc2 
        {
                get{
                if(casedoc2== null) casedoc2 = new Case_Document__c();
                return casedoc2;
                }
                set;
        }
        // created for the Alternative contacts
        
        
        public PageReference addcontact()
        {       
                if(contactlist.size()< 2)
                {
                        contactlist.add(new Case_Contact__c(Mailing_Address_Province__c='BC'));
                        
                }
                else if(contactlist.size()== 2)
                {
                        contactlist.add(new Case_Contact__c(Mailing_Address_Province__c='BC'));
                        isButtonDisabled = true; //disable the add button
                }               
                return null;    
        } 
        
                
                
        public PageReference removecontact()
        {
                contactlist.remove(numberOfRowToRemove);
                if(contactlist.size()<3)
                {
                        isButtonDisabled = false; //enable the add button
                }
                return null;    
        } 
        //Alternative contacts


        public PageReference step1() 
        {

      mapobj = [select id,Functional_Domain_Type__c,Context_prompt__c from Mapping_object__c where Functional_Domain_Type__c = 'ReferralPage1'
                                    LIMIT 1]; // added for defect 00051
        return page.CreateReferralPage1;
        }

        public static string phoneError(Referral__c pRef)
        {
                String result = '';
                /* String result1 = '';
                String result2 = '';
                String result3 = ''; */
                if(pRef == null)
                return result;
                boolean has_home_phone = false;
                boolean has_cell_phone = false;
                boolean has_work_phone = false;

                        if(pRef.Individual_Home_Phone_Number__c != null)
                        {
                                has_home_phone = (null != pRef.Individual_Home_Phone_Number__c || pRef.Individual_Home_Phone_Number__c.length() != 0);

                        }
                        if(pRef.Individual_Cell_Phone_Number__c != null)    
                        {
                                has_cell_phone = (null != pRef.Individual_Cell_Phone_Number__c || pRef.Individual_Cell_Phone_Number__c.length() != 0);

                        }
                        if(pRef.Individual_Work_Phone_Number__c != null)
                        {
                                has_work_phone = (null != pRef.Individual_Work_Phone_Number__c || pRef.Individual_Work_Phone_Number__c.length() != 0);

                        }   


                        if(!has_home_phone && !has_cell_phone && !has_work_phone)
                        {
                                pRef.Individual_Home_Phone_Number__c.adderror('Either home, cell, or work phone must be provided');
                                //result = 'Either home, cell, or work phone must be provided';
                                return 'Either home, cell, or work phone must be provided';
                        }
                return null;

        }

        public static string mailAddressError(Referral__c pRef)
        {
                system.debug('----pRef--------'+pRef);
                String result = '';
                if(pRef == null)
                return result;
                boolean addpost = false;
                boolean addcity = false;
                boolean addline1 = false;
                boolean check_mail_add = false;

                        if(pRef.Mailing_Address_same_as_Physical_Address__c != null) 
                                check_mail_add = (pRef.Mailing_Address_same_as_Physical_Address__c == null || pRef.Mailing_Address_same_as_Physical_Address__c != false);
                        if(pRef.Mailing_Address_Line_1__c != null)  
                                addline1 =(null != pRef.Mailing_Address_Line_1__c || pRef.Mailing_Address_Line_1__c.length() != 0);
                        if(pRef.Mailing_Address_City__c != null) 
                                addcity = (null != pRef.Mailing_Address_City__c || pRef.Mailing_Address_City__c.length() != 0);
                        if(pRef.Mailing_Address_Postal_Code__c != null)
                                addpost = (null != pRef.Mailing_Address_Postal_Code__c|| pRef.Mailing_Address_Postal_Code__c.length() != 0);    

                        // System.debug('check_mail_add'+check_mail_add); 
                        if(!check_mail_add && (!addline1 || !addcity || !addpost))
                        {
                                if(!addline1){
                                        pRef.Mailing_Address_Line_1__c.adderror('Please enter the Mailing address Line1');   
                                }
                                if( !addcity ){
                                        pRef.Mailing_Address_City__c.adderror('Please enter the City');     
                                }
                                if(!addpost){
                                        pRef.Mailing_Address_Postal_Code__c.adderror('Please enter the Postal Code');      
                        }

                        result = 'Please enter the complete mailing address ';
                        }
                return result;

        }

        public PageReference step2() 
        {
                // Validate 
                system.debug('----ref--------'+ref);
                system.debug('----blnshow--------'+blnshow);

                if(mailAddressError(ref).length() > 0)
                {
                        error_Mailadd = mailAddressError(ref);
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, error_Mailadd));
                        return null;    
                }
                else if(phoneError(ref) !=null)
                {          
                        
                        erorr_Phone = phoneError(ref);
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, erorr_Phone));
                        return null;
                }

                /* Ticket #680581: Remove automated process of 'match community' when  referral is created.
                 * if(ref.Physical_Address_Postal_Code__c != '')
                {
                     system.debug('----referral Postal Code--------'+ref.Physical_Address_Postal_Code__c);
                    String str3Digit = ref.Physical_Address_Postal_Code__c.left(3);
                    List<Postal_Code__c> lstPCobj = [select id,Community__c,Six_Digits__c,Three_Digits__c from Postal_Code__c where Name=: ref.Physical_Address_Postal_Code__c OR Name =: str3Digit order by Name DESC];
                    if(!lstPCobj.IsEmpty() && lstPCobj.size()>0)
                    {
                        system.debug('----Postal Code--------'+lstPCobj[0].Community__c);
                        ref.Community__c = lstPCobj[0].Community__c;
                    }
                    else
                    {
                        ref.Community__c = 'Unknown';
                    }
                }*/
                /*blnshow = false;
                if(ref.Individual_Date_of_Birth__c!=null)
                {
                        if(ref.Individual_Date_of_Birth__c >= date.today().addyears(-19))
                        {
                                blnshow = true;
                        }
                }*/
                mapobj = [select id,Functional_Domain_Type__c,Context_prompt__c from Mapping_object__c where Functional_Domain_Type__c = 'ReferralPage2'
                                    LIMIT 1]; // added for defect 00051

        return Page.CreateReferralPage2;
        }

        public PageReference step3() 
        {
                String result = '';
                String result4 = '';
                String result5 = '';
                String result6 = '';
                boolean pri_con_add = false;
                boolean pri_con_lname = false;
                boolean pri_con_fname = false;
                boolean pri_con_rel = false;
                boolean has_cell_phone = false;
                boolean has_work_phone = false;
                boolean has_home_phone = false;
                refcon.Relationship_Subtype__c = sRelSubtypeSelected;

                if(ref.Primary_Contact_Is_Individual_Indicator__c != null)
                        pri_con_add = (null == ref.Primary_Contact_Is_Individual_Indicator__c || ref.Primary_Contact_Is_Individual_Indicator__c != false);
                
                if(refcon.Contact_Person_Last_Name__c != null)
                        pri_con_lname = (null != refcon.Contact_Person_Last_Name__c || refcon.Contact_Person_Last_Name__c.length() != 0);
                if(refcon.Contact_Person_First_Name__c != null)    
                        pri_con_fname = (null != refcon.Contact_Person_First_Name__c || refcon.Contact_Person_First_Name__c.length() != 0);


                if(refcon.Contact_Person_Home_Phone_Number__c != null)
                {
                        has_home_phone = (null != refcon.Contact_Person_Home_Phone_Number__c || refcon.Contact_Person_Home_Phone_Number__c.length() != 0);

                }    
                if(refcon.Contact_Person_Work_Phone_Number__c != null)    
                {
                        has_cell_phone = (null != refcon.Contact_Person_Work_Phone_Number__c || refcon.Contact_Person_Work_Phone_Number__c.length() != 0);

                }
                if(refcon.Contact_Person_Cell_Phone_Number__c != null)
                {
                        has_work_phone = (null != refcon.Contact_Person_Cell_Phone_Number__c || refcon.Contact_Person_Cell_Phone_Number__c.length() != 0);

                }

                //if(sRelSubtypeSelected != null)
                        pri_con_rel = (sRelSubtypeSelected != '--None--');
                if(  sRelSubtypeSelected == 'Other' && refcon.Other_Relationship__c == null)
                {
                            refcon.Other_Relationship__c.adderror('For the Primary Contact, please specify the relationship to Individual (if other)');
                            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'For the Primary Contact, please specify the relationship to Individual (if other)'));
                             return null;  
                }
                 
                if(!pri_con_add) 
                {
                //  result = 'Error';
                        if((!has_cell_phone && !has_work_phone && !has_home_phone) || (!pri_con_lname || !pri_con_fname || !pri_con_rel)) 
                        {
                        result = 'Please enter the primary contact details:';

                                if( !pri_con_fname ){
                                        refcon.Contact_Person_First_Name__c.adderror('Please enter the First Name');
                                        System.debug('###########################');
                                        //return null;    
                                }
                                if(!pri_con_lname){
                                        refcon.Contact_Person_Last_Name__c.adderror('Please enter the Last Name');
                                        //return null;      
                                }
                                if(!pri_con_rel){
                                        refcon.Relationship_Subtype__c.adderror('Please enter the Relationship to Individual');
                                        //return null;  
                                }
                                if((!has_cell_phone && !has_work_phone && !has_home_phone))
                                {
                                        refcon.Contact_Person_Home_Phone_Number__c.adderror('Please enter at least one phone number');
                                        //return null;   
                                }
                        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, result));

                        return null; ///gv
                        
                        }
                
                } 
                
                
                errorupdlst = new list<Case_Contact__c>();
                addionalerrlist =new list<Case_Contact__c>();
                 if(contactlist.size() >0)
                 { 
                        for(Case_Contact__c conlst : contactlist)
                        {
                                                         
                            //system.debug('error');                                                                                                         
                            if( conlst.Relationship_Subtype__c == 'Other' && (conlst.Other_Relationship__c == null || conlst.Other_Relationship__c.length() == 0)) // added condition for defect D-00348
                               {
                                       errorupdlst.add(conlst); 
                               }                               
                                    
                            ////added  for defect 345
                          boolean alt_con_lname = false;
                          boolean alt_con_fname = false;
                          boolean alt_con_role = false;
                          boolean alt_home_phone = true;
                          boolean alt_email = true;
                          
                                             
                          if(conlst.Contact_Person_Last_Name__c != null){
                            alt_con_lname = (conlst.Contact_Person_Last_Name__c.length() != 0);}
                          if(conlst.Contact_Person_First_Name__c != null){
                            alt_con_fname = (conlst.Contact_Person_First_Name__c.length() != 0);}
                          if(conlst.Relationship_Subtype__c != null){
                            alt_con_role =  (conlst.Relationship_Subtype__c != null ||conlst.Relationship_Subtype__c != '--None--');}
                          if(conlst.Contact_Person_Email_Address__c != null){
                            alt_email = (null != conlst.Contact_Person_Email_Address__c || conlst.Contact_Person_Email_Address__c.length() != 0);}
                          if(conlst.Contact_Person_Home_Phone_Number__c != null){
                            alt_home_phone = ( conlst.Contact_Person_Home_Phone_Number__c.length() != 0);}
                          
                            
                            if((!alt_con_role && !alt_email && !alt_home_phone ) || (!alt_con_lname || !alt_con_fname))

                                {                
                                    addionalerrlist.add(conlst);                                                      
                                }                 

                        }
                    if(addionalerrlist.size() >0)                
                    {  
                        result = 'Please enter the Additional Contact First Name and Last Name:';                              
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, result));
                        return null;
                     }      
                    if(errorupdlst.size() >0)
                    {                       
                          //  system.debug('error');                         
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'For the Additional Contact, please specify the relationship to Individual (if other)'));                                        
                        return null;           
                    }
                                        
                }   
                mapobj = [select id,Functional_Domain_Type__c,Context_prompt__c from Mapping_object__c where Functional_Domain_Type__c = 'ReferralPage3'
                                    LIMIT 1];     // added for defect 00051  
                     //start of change for defect 345
                boolean socon_con_add =false;
                boolean socon_con_lname = false;
                boolean socon_con_fname = false;
                boolean socon_con_role = false;
                boolean socon_home_phone = false;
                boolean socon_email = false;
                boolean socon_org_name = false;
                
                if(ref.Is_the_Individual_Attending_School_Indic__c != null)
                        socon_con_add = (null == ref.Is_the_Individual_Attending_School_Indic__c || ref.Is_the_Individual_Attending_School_Indic__c != false);
               // if(ref.Is_the_Individual_Attending_School_Indic__c != null)
                  //socon_con_add = (ref.Is_the_Individual_Attending_School_Indic__c == true);        
                if(socon.Contact_Person_Last_Name__c != null){
                socon_con_lname = (null != socon.Contact_Person_Last_Name__c || socon.Contact_Person_Last_Name__c.length() != 0);}
                if(socon.Contact_Person_First_Name__c != null){
                  socon_con_fname = (null != socon.Contact_Person_First_Name__c || socon.Contact_Person_First_Name__c.length() != 0);}
                if(socon.Contact_Person_Profession_Role__c != null){
                  socon_con_role =  (null != socon.Contact_Person_Profession_Role__c || socon.Contact_Person_Profession_Role__c.length() != 0);}
                if(socon.Contact_Person_Email_Address__c != null){
                  socon_email = (null != socon.Contact_Person_Email_Address__c || socon.Contact_Person_Email_Address__c.length() != 0);}
                if(socon.Contact_Person_Home_Phone_Number__c != ''){
                  socon_home_phone = ('' != socon.Contact_Person_Home_Phone_Number__c || socon.Contact_Person_Home_Phone_Number__c.length() != 0);}
                if(socon.Organization_Name__c != null){
                  socon_org_name = (null != socon.Organization_Name__c || socon.Organization_Name__c.length() != 0);}
              
                if((socon_con_add) && (socon_con_role || socon_email || socon_home_phone || socon_org_name || socon_con_lname || socon_con_fname))
                {
                    if(!socon_con_lname || !socon_con_fname)
                     {
                        result = 'Please enter the School Contact First Name and Last Name:';                    
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, result));
                        return null;                  
                     }
                }
                boolean cfd_con_add = false;
                boolean cfd_con_lname = false;
                boolean cfd_con_fname = false;
                boolean cfd_con_role = false;
                boolean cfd_home_phone = false;
                boolean cfd_email = false;
                boolean cfd_org_name = false;
                
                if(ref.Is_the_individual_being_supported_by_CFD__c != null)
                  cfd_con_add = (null == ref.Is_the_individual_being_supported_by_CFD__c || ref.Is_the_individual_being_supported_by_CFD__c != false);                        
                if(cfdcon.Contact_Person_Last_Name__c != null){
                cfd_con_lname = (null != cfdcon.Contact_Person_Last_Name__c || cfdcon.Contact_Person_Last_Name__c.length() != 0);}
                if(cfdcon.Contact_Person_First_Name__c != null){
                  cfd_con_fname = (null != cfdcon.Contact_Person_First_Name__c || cfdcon.Contact_Person_First_Name__c.length() != 0);}
                if(cfdcon.Contact_Person_Profession_Role__c != null){
                  cfd_con_role =  (null != cfdcon.Contact_Person_Profession_Role__c || cfdcon.Contact_Person_Profession_Role__c.length() != 0);}
                if(cfdcon.Contact_Person_Email_Address__c != null){
                  cfd_email = (null != cfdcon.Contact_Person_Email_Address__c || cfdcon.Contact_Person_Email_Address__c.length() != 0);}
                if(cfdcon.Contact_Person_Home_Phone_Number__c != ''){
                  cfd_home_phone = ('' != cfdcon.Contact_Person_Home_Phone_Number__c || cfdcon.Contact_Person_Home_Phone_Number__c.length() != 0);}
                if(cfdcon.Organization_Name__c != null){
                  cfd_org_name = (null != cfdcon.Organization_Name__c || cfdcon.Organization_Name__c.length() != 0);}
                
                 if((cfd_con_add) && (cfd_con_role || cfd_email || cfd_home_phone || cfd_org_name || cfd_con_lname || cfd_con_fname))
                  {      
                        if(!cfd_con_lname || !cfd_con_fname)
                        {
                          result = 'Please enter the CFD Contact First Name and Last Name:';             
                          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, result));
                          return null;
                        }              
                  } 
                
                boolean clbc_con_add = false;
                boolean clbc_con_lname = false;
                boolean clbc_con_fname = false;
                boolean clbc_con_role = false;
                boolean clbc_home_phone = false;
                boolean clbc_email = false;
                boolean clbc_org_name = false;
                
                if(ref.Is_the_Individual_eligible_for_CLBC_Serv__c != null)
                  clbc_con_add = (null == ref.Is_the_Individual_eligible_for_CLBC_Serv__c || ref.Is_the_Individual_eligible_for_CLBC_Serv__c != false);                        
                if(clbccon.Contact_Person_Last_Name__c != null){
                clbc_con_lname = (null != clbccon.Contact_Person_Last_Name__c || clbccon.Contact_Person_Last_Name__c.length() != 0);}
                if(clbccon.Contact_Person_First_Name__c != null){
                  clbc_con_fname = (null != clbccon.Contact_Person_First_Name__c || clbccon.Contact_Person_First_Name__c.length() != 0);}
                if(clbccon.Contact_Person_Profession_Role__c != null){
                  clbc_con_role =  (null != clbccon.Contact_Person_Profession_Role__c || clbccon.Contact_Person_Profession_Role__c.length() != 0);}
                if(clbccon.Contact_Person_Email_Address__c != null){
                  clbc_email = (null != clbccon.Contact_Person_Email_Address__c || clbccon.Contact_Person_Email_Address__c.length() != 0);}
                if(clbccon.Contact_Person_Home_Phone_Number__c != ''){
                  clbc_home_phone = ('' != clbccon.Contact_Person_Home_Phone_Number__c || clbccon.Contact_Person_Home_Phone_Number__c.length() != 0);}
                if(clbccon.Organization_Name__c != null){
                  clbc_org_name = (null != clbccon.Organization_Name__c || clbccon.Organization_Name__c.length() != 0);}
                
                if((clbc_con_add) && (clbc_con_role || clbc_email || clbc_home_phone || clbc_org_name || clbc_con_lname || clbc_con_fname))
                {        
                    if(!clbc_con_lname || !clbc_con_fname)
                    {
                      result = 'Please enter the CLBC Contact First Name and Last Name:';                      
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, result));
                      return null; 
                     } 
             
                 }               
                        //end of change for defect 345
            
        return Page.CreateReferralPage3;
        }

        public PageReference save() 
        {
                List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
                String MyProflieName = PROFILE[0].Name;
                //Boolean ifPortaluser = PROFILE[0].PermissionsPortalSuperUser;
                List<User> portaluser = [SELECT Id, Name, UserType FROM User WHERE Id=:userinfo.getUserId() LIMIT 1];
                String ifPortaluser = portaluser[0].UserType;
                finalUpdateconlst = new list<Case_Contact__c>();
                                system.debug('----ifPortaluser----'+ifPortaluser);
                                
                if((vDocument2.Body!= null && vDocument.Body != null) || (MyProflieName =='System Administrator' || ifPortaluser != 'PowerPartner'))
                // Should get error STADD support , IFSN 
                {
                        try
                        {                
                                ref.Status__c = 'Pending';
                                // TODO: replae with query to Record type
                                List<RecordType> rectype =[Select Id,Name From RecordType Where Name = 'Standard' and SobjectType ='Referral__c' limit 1];
                                ref.RecordTypeId = rectype.get(0).id;
                                if(ref.Type_of_Referral__c == 'Self/Direct Referral')
                                {
                                  ref.Referring_Organization__c = null;
                                }
                                insert ref;

                                if(ref.Primary_Contact_Is_Individual_Indicator__c == false)
                                {
                                        refcon.Referral__c = ref.id;
                                        refcon.Contact_Type__c = 'Primary';
                                        
                                        insert refcon;   
                                }
                                if((ref.Is_the_Individual_Attending_School_Indic__c == true) && (socon.Contact_Person_First_Name__c != null && socon.Contact_Person_Last_Name__c != null))
                                {
                                        socon.Referral__c =ref.id;
                                        socon.Contact_Type__c = 'Organizational';
                                        socon.Contact_Subtype__c ='School';
                                        insert socon;
                                }
                                if((ref.Is_the_individual_being_supported_by_CFD__c == true) && (cfdcon.Contact_Person_First_Name__c!= null && cfdcon.Contact_Person_Last_Name__c != null))
                                {
                                        cfdcon.Referral__c =ref.id;
                                        cfdcon.Contact_Type__c = 'Organizational';
                                        cfdcon.Contact_Subtype__c ='CFD';
                                        insert cfdcon;
                                }
                                if((ref.Is_the_Individual_eligible_for_CLBC_Serv__c == true) && (clbccon.Contact_Person_First_Name__c!= null && clbccon.Contact_Person_Last_Name__c != null))
                                {
                                        clbccon.Referral__c=ref.id;
                                        clbccon.Contact_Type__c = 'Organizational';
                                        clbccon.Contact_Subtype__c ='CLBC';
                                        insert clbccon;
                                }     
                                // Inserting the alternative contacts
                                
                                
                                
                                if(contactlist.size() >0)
                                { 
                                        for(Case_Contact__c conlst : contactlist)
                                        {
                                                if(conlst.Contact_Person_First_Name__c != null || conlst.Contact_Person_Last_Name__c != null)
                                                {                               
                                                        conlst.Referral__c = ref.id; 
                                                        conlst.Contact_Type__c = 'Alternative';                                                                                                                                                                                        
                                                        finalUpdateconlst.add(conlst);// creates list of contacts where firstname and lastname not null                                                       
                                                        //}
                                                }                                               
                                        } 
                                        if(finalUpdateconlst.size()>0)             
                                        insert finalUpdateconlst;//inserts the referral contacts
                                }  

                                if(vDocument.Body!= null)
                                {
                                        List<RecordType> casdocrectype1 =[Select Id,Name From RecordType Where Name = 'collaborative' and SobjectType ='Case_Document__c' limit 1];
                                        casedoc.RecordTypeId = casdocrectype1.get(0).id;
                                        casedoc.Name = 'Individual Consent'; 
                                        casedoc.Category__c = 'Individual';
                                        casedoc.Sub_Category__c='Consent';
                                        casedoc.Referral__c = ref.id;  
                                        insert casedoc; 
                                        
                                        string dname = vDocument.Name;
                                        //string split= dname.substring(dname.length()-3, dname.length());
                                                                                     
                                       // List<String> parts = dname.split('\\.');
                                        //system.debug('######gvgv' + parts);
                                                                //    string split1 = parts[parts.size()-1]; 
                                                                    //system.debug('######gvgv' + split1); 
                                                                    
                                                                   // vDocument.Name = 'Consent'+'.'+ split1;      //   Removed as part of CC release post R1.2      
                                        vDocument.parentId = casedoc.Id;
                                        insert vDocument;   
                                }          
                                                  

                                if(vDocument2.Body!= null)
                                {
                                        List<RecordType> casdocrectype2 =[Select Id,Name From RecordType Where Name = 'Restricted' and SobjectType ='Case_Document__c' limit 1];
                                        casedoc2.RecordTypeId = casdocrectype2.get(0).id;
                                        casedoc2.Referral__c = ref.id;
                                        casedoc2.Name = 'Assessment Diagnosis'; 
                                        casedoc2.Category__c = 'Assessment';
                                        casedoc2.Sub_Category__c='Diagnosis Proof';
                                        insert casedoc2;
                                        
                                        string dname2 = vDocument2.Name;
                                        //List<String> parts1 = dname2.split('\\.');                                      
                                       //                             string split2 = parts1[parts1.size()-1]; 
                                        //vDocument2.Name = 'Assessment'+'.'+ split2;      // Removed as part of CC release post R1.2 
                                       
                                        vDocument2.parentId = casedoc2.Id;
                                        insert vDocument2;  
                                }
                                // START: MH (30/09/13): sharing record with submitter
                                Referral__Share referralShr = new Referral__Share ();
                                referralShr.ParentId = ref.id;
                                referralShr.UserOrGroupId = userinfo.getuserID();
                                referralShr.AccessLevel = 'Read';
                                referralShr.RowCause = Schema.Referral__Share.RowCause.Self_Sharing__c;
                                insert(referralShr);

                                // END: MH (30/09/13): sharing record with submitter
                                          
                        } // MH (30/09/13) end of if profile ... please fix indenting in this file
                        catch (DMLException e)
                        {
                                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please contact the administrator'));
                                return null;
                        } 
                        finally {
                                vDocument.body = null;          
                                docId = vDocument.Id; 
                                vDocument2.body = null;    
                                docId = vDocument2.Id;// clears the viewstate
                        }
                                   
                        PageReference refPage = new PageReference('/' + ref.Id);                
                        refPage.setRedirect(true);
                        Referral__c r = [Select Name from Referral__c where Id = :ref.Id limit 1];
                        refPage.getParameters().put('Name',r.Name);            
                        vDocument.body = null;
                        vDocument2.body = null;
                        return refPage;

                }
                else
                {

                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please attach the required forms'));
                        vDocument.body = null;
                        vDocument2.body = null;
                        return null;
                }           
        }
}