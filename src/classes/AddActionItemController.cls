public with sharing class AddActionItemController {
    
    //public Plan_Milestone__c[] milestones {get; set;}
    
    // URL construction helpers
    public static String baseUrl {get; private set;}
    public static String actionItemPlanMilestone_fieldId {get; private set;}

    static {
        loadUrlHelpers();
    }
    
    
    public AddActionItemController() {
        loadMilestones();
    }
    
    public void loadMilestones() {
        Map<Id, Case> cases = new Map<Id, Case>([Select Id From Case Limit 1000]);
         //0000670296 Partner dashboard/ homepage edits. The below query is no longer required because of this ticket. 
        /*this.milestones = [Select 
            Name, Plan_Goal__c, Plan_Goal__r.Name, Plan_Goal__r.Plan__c, Plan_Goal__r.Plan__r.Name, Plan_Goal__r.Plan__r.Case__c, Plan_Goal__r.Plan__r.Case__r.CaseNumber
            From Plan_Milestone__c Where Plan_Goal__r.Plan__r.Case__c in :cases.keySet()
            Order By Plan_Goal__r.Plan__r.Case__r.CaseNumber, Plan_Goal__r.Plan__r.Name, Plan_Goal__r.Name, Name];*/
    }
    
    private static void loadUrlHelpers() {
        baseUrl = URL.getSalesforceBaseUrl().toExternalForm();
        if (Site.getPrefix() != null) {
            String postfix = '/' + Site.getPrefix();
            postfix = postfix.replaceAll('//', '/');
            baseUrl += postfix;
        }
        actionItemPlanMilestone_fieldId = ObjectHelper.fieldIdMap('Action_Item__c').get('Plan Milestone');
    }
}