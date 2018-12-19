@isTest
public class BatchOnCaseTeamSize_Test { 
	static testMethod void myUnitTest()
	{
		BatchOnCaseTeamSize objTest = new BatchOnCaseTeamSize();
		Database.executebatch(objTest);
	}
		
}