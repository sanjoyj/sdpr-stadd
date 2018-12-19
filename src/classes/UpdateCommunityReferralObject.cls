/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: UpdateCommunityReferralObject
** Description: To define the invocable method so that Community field is updated based on Postal Code
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Sanjoy                     11/02/2018                          Created
********************************************************************************************/
public class UpdateCommunityReferralObject {

        @InvocableMethod(label='Update Community on Referral' description='Updates the Community Field depending on Physical Postal Code')
    public static void updateCommunityReferral(List<Id> referralToUpdate) {
        //Map<String, String> compareChart= new Map <String, String>();
        //Map<Id, Postal_Code__c> postalCodeMap= new Map <Id, Postal_Code__c>([Select Name, Six_Digits__c,Community__c FROM Postal_Code__c where Six_Digits__c=True]);
        //for(Id posId: postalCodeMap.keyset()) {
        //compareChart.put(postalCodeMap.get(posId).Name,postalCodeMap.get(posId).Community__c);
        //}
        Map< Id, Referral__c> referralMap= new Map <Id, Referral__c>([Select Physical_Address_Postal_Code__c, Community__c FROM Referral__c where Id IN :referralToUpdate ]);
          for (String referralID : referralMap.keySet()){
                  String posCode=(referralMap.get(referralID).Physical_Address_Postal_Code__c).left(3)+(referralMap.get(referralID).Physical_Address_Postal_Code__c).right(3);
                  List <Postal_Code__c> postalList=[Select Name, Six_Digits__c,Community__c FROM Postal_Code__c where Name=: posCode];
                  If(!postalList.isEmpty())
                  referralMap.get(referralID).Community__c=postalList[0].Community__c;
                  else
                  referralMap.get(referralID).Community__c='Unknown';  
}
        update referralMap.values();
}
}