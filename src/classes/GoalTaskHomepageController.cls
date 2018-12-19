public with sharing class GoalTaskHomepageController {
    
    public CaseVO[] cases {get; set;}
    public Action_Item__c[] actionItems {get; set;}
    public Contribution__c[] contributions {get; set;} 
    public String actionItemFilter {get; set;}
    
    // URL construction helpers
    public static String baseUrl {get; private set;}
    public static String caseAlertObjectPrefix {get; private set;}
    public static String contributionObjectPrefix {get; private set;}
    public static String functionalDomainObjectPrefix {get; private set;}
    public static String caseAlertRelatedListId {get; private set;}
    public static String contributionRelatedListId {get; private set;}
    public static String functionalDomainRelatedListId {get; private set;}

    public static String alertCase_fieldId {get; private set;}
    public static String contributionCase_fieldId {get; private set;}
    public static String docCase_fieldId {get; private set;}
    public static String actionItemStatus_fieldId {get; private set;}

    static {
        loadUrlHelpers();
    }
    
    public Datetime lastLoginDate {get; private set;}
    
    public class CaseVO {
        public Case obj {get; set;} // 'case' is a reserved keyword.
        public Boolean selected {get; set;}
        
        public Boolean hasNewAlert {get{
            return newAlertCount != 0;
        }}
        public Integer newAlertCount {get{
            return (obj.Case_Alerts1__r == null) ? 0 : obj.Case_Alerts1__r.size();
        }}
        
        public Boolean hasNewContribution {get{
            return newContributionCount != 0;
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

    public GoalTaskHomepageController() {
        setLastLogin();
        loadCases();
        loadActionItems();
    }
    
    public void loadCases() {
        this.cases = new List<CaseVO>();
        Case[] caseObjects =
            [Select CaseNumber, ContactId, Contact.Name, Subject, Status, LastModifiedDate,
            (Select Name, CreatedDate From Case_Alerts1__r Where CreatedDate >= :lastLoginDate),
            (Select Name, CreatedDate From Contributions__r Where CreatedDate >= :lastLoginDate),
            (Select Name, CreatedDate From Functional_Domains__r Where CreatedDate >= :lastLoginDate)
            From Case Order By LastModifiedDate DESC Limit 250];
        Map<Id, List<Action_Item__c>> overdueActionItemsMap = loadOverdueActionItems(caseObjects);
        for (Case c : caseObjects) {
            this.cases.add(new CaseVO(c, overdueActionItemsMap.get(c.id))); 
        }
    }
    
    public void loadActionItems() {
        actionItemFilter = (actionItemFilter == null) ? 'allOpen' : actionItemFilter;
        this.actionItems = new List<Action_Item__c>();
        Date today = Date.today();
        String query = 'Select Name, Status__c, Individual_Name__c, Activity__c, Description__c, Review_Date__c, Action_Item_Type__c, Priority__c';
        query += ' From Action_Item__c Where Assigned_To__c = \'' + UserInfo.getUserId() + '\'';
        if (actionItemFilter == 'allOpen') {
            this.actionItems = Database.query(query + ' and Status__c != \'Complete\' and Status__c != \'No Longer Required\' ORDER BY Review_Date__c ASC'); // Reju modified for defect D-00180 and D-00349
        }
        if (actionItemFilter == 'overdue') {
            this.actionItems = Database.query(query + ' and Status__c != \'Complete\' and Status__c != \'No Longer Required\' and Review_Date__c <= :today ORDER BY Review_Date__c ASC'); // Reju modified for defect D-00180 and D-00349
        }
        if (actionItemFilter == 'nextSevenDays') {
            Date sevenFromToday = Date.today().addDays(7);
            this.actionItems = Database.query(query + ' and Status__c != \'Complete\' and Status__c != \'No Longer Required\' and Review_Date__c <= :sevenFromToday and Review_Date__c >= :today ORDER BY Review_Date__c ASC'); // Reju modified for defect D-00180 and D-00349
        }
        if (actionItemFilter == 'nextTwoWeeks') {
            Date fourteenFromToday = Date.today().addDays(14);
            this.actionItems = Database.query(query + ' and Status__c != \'Complete\' and Status__c != \'No Longer Required\' and Review_Date__c <= :fourteenFromToday and Review_Date__c >= :today ORDER BY Review_Date__c ASC'); //Reju modified for defect D-00180 and D-00349
        }
        
    }
    
    public Map<Id, List<Action_Item__c>> loadOverdueActionItems(Case[] caseObjects) {
        Set<Id> caseIds = new Set<Id>();
        for (Case c : caseObjects) {
            caseIds.add(c.Id);
        }
        map<Id, List<Action_Item__c>> caseIdsToOverdueActionItems = new Map<Id, List<Action_Item__c>>();
        List<Action_Item__c> actionItems = [Select Id, Plan__r.Case__c,Individual_Name__c from Action_Item__c 
          where Status__c != :'Complete' and Review_Date__c <= TODAY and Plan__r.Case__c IN :caseIds];

        for(Action_Item__c actionItem : actionItems) {
            Id caseId = actionItem.Plan__r.Case__c;
            if (!caseIdsToOverdueActionItems.containsKey(caseId)) {
                caseIdsToOverdueActionItems.put(caseId, new List<Action_Item__c>()); 
            }
            caseIdsToOverdueActionItems.get(caseId).add(actionItem);
        }
        
        return caseIdsToOverdueActionItems;
    }
    
    private static void loadUrlHelpers() {
        baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        if (Site.getPrefix() != null) {
            baseUrl +=  Site.getPrefix();
        }
        caseAlertObjectPrefix = ObjectHelper.getObjectPrefix('Case_Alert__c');
        // This changes between orgs. Update after deploying to production.        
        caseAlertRelatedListId = '00Ni000000BeUcS'; //config
        // 00Ni0000008Excf config
        // 00Nf0000000HuKO sprint2
        // 00Nf0000000Py7S sprint1
        // 00Ni000000BeUcS production
        
        contributionObjectPrefix = ObjectHelper.getObjectPrefix('Contribution__c');
        // This changes between orgs. Update after deploying to production.        
        contributionRelatedListId = '00Ni000000EpmPB';
        // 00Nf0000000ttfm config
        // 00Ni000000EpmPB production
       
        functionalDomainObjectPrefix = ObjectHelper.getObjectPrefix('Functional__c');
        // This changes between orgs. Update after deploying to production.
        functionalDomainRelatedListId = '00Ni000000BeUdX'; //config
        // 00Nf0000000Pztg config
        // 00Nf0000000IO9d sprint2
        // 00Nf0000000Q159 sprint1
        // 00Ni000000BeUdX production

        alertCase_fieldId = ObjectHelper.fieldIdMap('Case_Alert__c').get('Case');
        contributionCase_fieldId = ObjectHelper.fieldIdMap('Contribution__c').get('Case');
        docCase_fieldId = ObjectHelper.fieldIdMap('Case_Document__c').get('Case');
        
        actionItemStatus_fieldId = ObjectHelper.fieldIdMap('Action_Item__c').get('Status');
    }
    
    private void setLastLogin() {
        // Always skip last 3 days.
        LoginHistory lastLogin = null;
        for (LoginHistory l : [SELECT UserId, LoginTime from LoginHistory 
            where UserId = :System.UserInfo.getUserId() and LoginTime < :Datetime.now().addDays(-3)
            ORDER BY LoginTime DESC NULLS LAST Limit 1]) {
            lastLogin = l;
        }
        
        // if no previous login, set back 2 months
        lastLoginDate = (lastLogin == null) ? Datetime.now().addDays(-60) : lastLogin.LoginTime;
    }
}