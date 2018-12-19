/* Class Name  : MyProfilePageController_Test
 * Description : Test class for an Apex class MyProfilePageController 
 * Created By  : Silviu Frantescu
 * Created On  : 10-01-2013
*/

@isTest
private class MyProfilePageController_Test{
     /*private static testmethod void insertPortalUser(){
        User newUser; 
        User GuestUser;
        test.starttest();         
        User loggedInUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        system.runAs(loggedInUser ){
            Account acc = new Account (Name = 'newAcc1'); 
            insert acc;
            Contact con = new Contact (AccountId = acc.id,LastName = 'portalTestUser');
            insert con;
            Profile p = [SELECT Id, Name FROM Profile WHERE Name='STADD support team (login)' LIMIT 1];
            UserRole ur = [Select PortalType, PortalAccountId From UserRole where name='jgilm Customer Person Account' and PortalType ='CustomerPortal' limit 1]; 
            newUser = new User(profileId = p.id,username = 'newUser@yahoo.com', email = 'pb@ff.com',emailencodingkey = 'UTF-8',
                    localesidkey = 'en_US',languagelocalekey = 'en_US',timezonesidkey = 'America/Los_Angeles',alias='nuser',lastname='lastname',contactId = con.id);
            insert newUser;  
            GuestUser = new User(profileId = p.id, usertype = 'GUEST', username = 'newUser@yahoo.com', email = 'pb@ff.com',emailencodingkey = 'UTF-8',
                    localesidkey = 'en_US',languagelocalekey = 'en_US',timezonesidkey = 'America/Los_Angeles',alias='nuser',lastname='lastname',contactId = con.id);
            insert GuestUser ;            
        } 
        system.runAs(newUser){
            MyProfilePageController obj = new MyProfilePageController();
            obj.save();
            obj.changePassword();
            obj.edit();
            obj.cancel();
            system.assertNotEquals(newUser, null);
        }
        
        test.stoptest();   
     }  */
    
}