@isTest
private class GoalTaskHomepageControllerTest {

    static testMethod void testLastLoginDate() {
        GoalTaskHomepageController gthc = new GoalTaskHomepageController();
        system.assertNotEquals(null, gthc.lastLoginDate, 'Last Login Date was null.');
    }
    
    static testMethod void testLoadCases() {
        Account a = new Account(Name = 'Example GTHC Account');
        insert a;
        Contact c = new Contact(AccountId = a.Id, FirstName = 'Example', LastName = 'Exampler');
        insert c;
        Case ca = new Case(AccountId = a.Id, ContactId = c.id, Subject = 'A Test Case');
        insert ca;
        GoalTaskHomepageController gthc = new GoalTaskHomepageController();
        system.assertNotEquals(null, gthc.cases, 'Case list was null.');
        system.assertEquals(1, gthc.cases.size(), 'Case list size was not 1');
        GoalTaskHomepageController.CaseVO cvo = gthc.cases[0];
        system.assertEquals(0, cvo.newAlertCount, 'Case should not have new alerts');
        system.assertEquals(false, cvo.hasNewAlert, 'Case should not have new alert flag set');
        system.assertEquals(0, cvo.newContributionCount, 'Case should not have new contributions');
        system.assertEquals(false, cvo.hasNewContribution, 'Case should not have new contribution flag set');
        system.assertEquals(0, cvo.newFunctionalDomainCount, 'Case should not have new functional domain summaries');
        system.assertEquals(false, cvo.hasNewFunctionalDomain, 'Case should not have new functional domain summary flag set');
        system.assertEquals(0, cvo.overdueActionItemsCount, 'Case should not have overdue action items');
        system.assertEquals(false, cvo.hasOverdueActionItems, 'Case should not have overdue action items flag set');
    }
    
    public class CaseVO {
        public Case obj {get; set;} // 'case' is a reserved keyword.
        public Boolean selected {get; set;}
        public Boolean hasNewAlert {get{
            return newAlertCount != 0;
        }}
        public Integer newAlertCount {get{
            return (obj.Case_Alerts1__r == null) ? 0 : obj.Case_Alerts1__r.size();
        }}
        public Integer newContributionCount {get{
            return (obj.Contributions__r == null) ? 0 : obj.Contributions__r.size();
        }}
        public Boolean hasNewFunctionalDomain {get{
            return newFunctionalDomainCount != 0;
        }}
        public Integer newFunctionalDomainCount {get{
            return (obj.Functional_Domains__r == null) ? 0 : obj.Functional_Domains__r.size();
        }}
        
        private List<Action_Item__c> overdueActionItems {get; set;}
        public Boolean hasOverdueActionItems {get{
            return overdueActionItemsCount > 0;
        }}
        public Integer overdueActionItemsCount {get{
            return (overdueActionItems == null) ? 0 : overdueActionItems.size();
        }}
        
        public CaseVO(Case c, List<Action_Item__c> overdueActionItems) {
            obj = c;
            selected = false;
            this.overdueActionItems = overdueActionItems;
        } 
    }
}