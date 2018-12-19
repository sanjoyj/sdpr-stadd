/*
******************************************************************************************
** ICM STADD Project
*******************************************************************************************
* @Class Name   : RejectCaseController
* @Description  : Created the controller for Reject case button
* @Created By   : Reju Palathingal
* @Created On   : 06/09/2013
* @Modification Log:  
* -----------------------------------------------------------------------------
* @Developer                Date                  Description 
* -----------------------------------------------------------------------------
*                                       
* -----------------------------------------------------------------------------
*/
public class RejectCaseController{
    public Referral__c record {get;set;}
    //Public list<Case> caseReclist {get; set;}
    public Id id{get;set;}
    //Constructor for the page
    public RejectCaseController(ApexPages.StandardController controller) {
         id=  ApexPages.currentPage().getParameters().get('id');
         record =[Select Id,status__c,Sub_Status__c,Ownerid from Referral__c where id =:id];
         if(record != null){
         record.Status__c = 'Rejected';
         //record.Sub_Status__c = 'Duplicate';
         }
    }
    // Logic for reject 
    public pagereference RejectCase(){
        Id recordId = System.currentPagereference().getParameters().get('id');  
        List<Referral__c> ref = [Select Id,OwnerId,status__c,Sub_Status__c from Referral__c where id =:recordId];
        String own;
        If(!ref.isEmpty())
        own = ref[0].OwnerId;
        Profile PR = [select Name from Profile where id =:userinfo.getProfileId()];
        if (own!=null && own.startsWith('00G') && PR.Name != 'STADD Coordinator') 
            {
                 ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, 'Please make sure the referral has been assigned to a navigator before accepting/rejecting it; only navigators who own the referral can accept/reject'));
                 return null;
            }
        //List<User> portaluser = [SELECT Id, Name, IsPortalEnabled, UserType FROM User WHERE Id=:userinfo.getUserId() LIMIT 1];
        //userinfo.getProfileId();
        if (PR.Name == 'STADD Navigator' )
        {
            ID id1 = userinfo.getUserId();
            if(id1 != ref[0].OwnerId)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please make sure the referral has been assigned to a navigator before accepting/rejecting it; only navigators who own the referral can accept/reject'));
                return null;
            }
        }
        if(record != null){
        update record;
        //PageReference casPage = new PageReference('/' + record[0].Id);
        PageReference casPage = new PageReference('/' + record.Id);
        casPage.setRedirect(true);
        return casPage;
        }
        else{
            return null;
        }        
    }
}