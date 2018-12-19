/* Class: UpdatePCCommunity
 * Developer: Subodh Bahl
 * Description: This class updates the community once the update community button is clicked
 * Modification Logs:
 * Modified By                            Modified Date                      Comments                         
 * Subodh Bahl                            23/01/2015                         Created.
 */

global class UpdatePCCommunity{

    /* Developer : Subodh bahl 
     * Description : This method finds a match for the postal code in the Postal Code Object and calls the update method accordingly
     */
    /*
    webservice static void CheckCommunityCode(String strPostalCode,String id){ 
       
        system.debug('pdcode'+strPostalCode+';..Id :'+id);
        
        // Variables
        List <Postal_Code__c> listPostalCode = new List <Postal_Code__c>();
        String postalCode;
        String communityName;
        Boolean matchFound = false;
        try{
          /*  listPostalCode = [select id,Community__c, Name from Postal_Code__c];
            
            String str3Digit = strPostalCode.left(3);
            system.debug('pststr3Digit...:'+str3Digit);
            
            for(integer i = 0; i < listPostalCode.size(); i++ ){
                postalCode      = listPostalCode[i].Name; 
                if(postalCode == strPostalCode){
                    matchFound = true; 
                    communityName   = listPostalCode[i].Community__c;
                    system.debug('6digit....:'+communityName);
                }
                system.debug('matchFound...:'+matchFound);
               if(postalCode == str3Digit && matchFound != true)
               {
               	 	matchFound = true; 
                    communityName   = listPostalCode[i].Community__c;
                    system.debug('3digit...:'+communityName);
               	
               }
            }
           
            String str3Digit = strPostalCode.left(3);
            system.debug('pststr3Digit...:'+str3Digit);
			List<Postal_Code__c> lstPCobj = [select id,Community__c,Six_Digits__c,Three_Digits__c from Postal_Code__c where Name=: strPostalCode OR Name =: str3Digit order by Name DESC];
				if(!lstPCobj.IsEmpty() && lstPCobj.size()>0)
					{
						system.debug('----Postal Code--------'+lstPCobj[0].Community__c);
						matchFound = true;
						communityName = lstPCobj[0].Community__c;
					}
					            
            if(matchFound == true)
             updateCommunityName(Id, communityName);
            else
             updateCommunityName(Id, 'Unknown');
             
         system.debug(matchFound);   
        }
        catch(Exception ex){
            System.debug('Exception' + ex);
        }
    }   



    /* Developer : Subodh Bahl
     * Description : This method updates a record based on the community name
     */
    /*
    public static void updateCommunityName(String id, String communityName){
        system.debug('JG');
        Referral__c referral    = new Referral__c(Id = id);
        referral.Community__c   = communityName;
        system.debug(referral);
        update referral; 
    } */
}