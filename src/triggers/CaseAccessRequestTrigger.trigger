/* Trigger Name : CaseAccessRequestTrigger 
 * Description  : This trigger gives read/write access to the newly created record for portal users
 *                (needed because a workflow changes the ownership).
 * Created By   : Moussa Horanieh
 * Created On   : 21-11-2013
*/
trigger CaseAccessRequestTrigger on Case_Access_Request__c (after insert) {

    // START: MH (21/11/13): sharing record with submitter (Defect 335) 
    if(Trigger.isAfter && Trigger.isInsert)
    {
        Case_Access_Request__Share CARShr = new Case_Access_Request__Share (); // to be improved: should be a set
        
        for(Case_Access_Request__c CAR: trigger.new)
        {
            CARShr.ParentId = CAR.id;
            CARShr.UserOrGroupId = userinfo.getuserID();
            CARShr.AccessLevel = 'Read';
            CARShr.RowCause = Schema.Case_Access_Request__Share.RowCause.Self_Sharing__c;
            insert(CARShr); // to be improved: not bulkified
        }
    }
    // END: MH (21/11/13): sharing record with submitter (Defect 335) 
    
}