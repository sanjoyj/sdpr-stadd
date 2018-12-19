/* TriggerName : PreventDeleteOnNotes 
 * Description  : This trigger is prevent the deletion of notes by user otherthan administrator.
 * Created By   : Reju Palathingal
 * Created On   : 8-4-2014
*/
trigger PreventDeleteOnNotes on Note (before delete) {
for (Note D: trigger.old)
    {
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        String MyProflieName = PROFILE[0].Name;
        if(  MyProflieName !='System Administrator')
        {
            D.adderror( 'Only a System Administrator can delete notes' );
        }
    }
}