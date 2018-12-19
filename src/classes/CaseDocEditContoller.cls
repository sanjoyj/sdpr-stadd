/******************************************************************************************
** ICM STADD Project
*******************************************************************************************
** Class Name: CaseDocEditContoller
** Description: This is class allows user to change the record type of the Document.
** Version: 1.0
** 
**-----------------------------------------------------------------------------------------
**Modification Log:
**----------------
**Developer                  Date          Version               Description
**-----------------------------------------------------------------------------------------
**Balaji Kotte          10/07/2014         1.0                   Created** 

********************************************************************************************/
public class CaseDocEditContoller
{
	Public Case_Document__c DocRecord {get; set;}
	public Id RecTypeId {get; set;}
	
	public CaseDocEditContoller(ApexPages.StandardController controller) {
        DocRecord = (Case_Document__c)controller.getRecord();
        RecTypeId =  ApexPages.currentPage().getParameters().get('RecordType');
        System.debug('RecTypeId :' + RecTypeId);
		DocRecord.RecordTypeId = RecTypeId;
    }
}