/******************************************************************************************
** ICM STADD Project
******************************************************************************************* 
 * @Class Name   : PlanReportPDF
 * @Description  : PDF Report controller Class
 * @Created By   : Gaurav Verma
 * @Created On   : 16 Oct 2013
 * @Modification Log:  
 * -----------------------------------------------------------------------------
 * @Developer                Date                  Description 
 * -----------------------------------------------------------------------------
 * @Gaurav Verma          16 Oct 2013               Created
 * 
 * -----------------------------------------------------------------------------
 */
public with sharing class PrintPlanController {
        public id pnid {get;set;}
        Public Plan__c record {get; set;}
        Public Case CS {get; set;}
        Public List<Plan__c> Plan1 {get; set;}
        public List<Plan_Goal__c> GoalLst1 {get;set;}
        public Plan__c Plan2 {get;set;}
        public List<Plan_Milestone__c> current {set; get;}
    public Map<id,List<Plan_Milestone__c>> mapMsUpdate {get;set;}
    public Map<Id, List<Action_Item__c>> mapMsAi {get;set;}
    public Set<id> setMsid {get;set;}
        // Constructor
        public PrintPlanController(ApexPages.StandardController controller)
        {
                record = (Plan__c)controller.getRecord();//Current Plan Record
                //Plan1 = [Select id, name, Plan_Type__c, Plan_Status__c, First_Meeting_Date__c from Plan__c where id =:record.id limit =1 ]
                Plan2 = [SELECT id, name, Plan_Type__c, Plan_Status__c, Assisted_Individual__c, Case_Owner__c, Date_of_Birth__c,First_meeting__c, First_Meeting_Date__c from Plan__c WHERE id =:record.id];
                //CS = [SELECT id, name from case WHERE id =: Plan2.Case__c];
                //PlanReclist = new list<Plan__c>();//Initializing the list   
        pnid=  ApexPages.currentPage().getParameters().get('id');
        System.debug('####%%%%gvgv%%%%>>>>>' + pnid);
        GoalLst1 = [select id,
                                                Name,
                                                Area_of_Importance__c,
                                                Case_ID__c,
                                                Goal__c,
                                                Plan__c,
                                                Important_steps_to_reach_this_goal__c,
                                                Important_to_me_because__c,
                                                (Select Id, Name From Plan_Milestones__r)
                                 from plan_goal__c where Plan__c =: pnid];
    System.debug('####%%%%gvgv%%%%>>>>>' + GoalLst1.size());
    setMsid = new Set<id>();
    mapMsUpdate = new Map<id,List<Plan_Milestone__c>>();
    mapMsAi = new Map<Id, List<Action_Item__c>>();
    if(GoalLst1.size()>0) 
        {
            mapMsUpdate = new    Map<id,List<Plan_Milestone__c>>(); 
            for(Plan_Goal__c G: GoalLst1)
            {
                list <Plan_Milestone__c> current = new list <Plan_Milestone__c>();
                current = G.Plan_Milestones__r;
                mapMsUpdate.put (G.id,current) ;
                 
                //setMsid.add(current.id);
                for(Plan_Milestone__c MS : current)
                {
                        //if (MS.id != Null)
                        setMsid.add(MS.id);
                }
            }
        }
        else 
        {
            ApexPages.addMessage ( new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Contact the Sysytem Admin'));
            //Return Null;
        } 
        
        //Map<Id, List<Action_Item__c>> mapMsAi = new Map<Id,List<Action_Item__c>>();
        for(Action_Item__c obj : [Select Id,
                                                                        Milestone__c,
                                                                        Action_Item_Type__c,
                                                                        Activity__c,
                                                                        Assigned_To__c,Assigned_To__r.Name,
                                                                        Bring_Forward__c,
                                                                        Bring_Forward_Date__c,
                                                                        Date_Completed__c,
                                                                        Description__c,
                                                                        Plan__c,
                                                                        Plan_Goal__c,
                                                                        Priority__c,
                                                                        Review_Date__c,
                                                                        Status__c
                                                                        From Action_Item__c Where Milestone__c In :setMsid])
        {
                /*List<Id> test = mapMsAi.get(obj.Milestone__c);
                if(test == null)
                {
                        test = new List<Id>();
                }
                test.add(obj.Id);
                mapMsAi.put(obj.Milestone__c,test);*/           
                
                if(mapMsAi.containskey(obj.Milestone__c))
                {
                        List<Action_Item__c> lstAction = mapMsAi.get(obj.Milestone__c);
                        lstAction.add(Obj);
                        mapMsAi.put(obj.Milestone__c,lstAction);
                        //mapMsAi.get(obj.Milestone__c).add(obj);
                }
                else
                {
                        List<Action_Item__c> lstAction = new List<Action_Item__c>(); 
                        lstAction.add(Obj);
                        mapMsAi.put(obj.Milestone__c,lstAction);
                }
                
                
        }
        for(Id PM: setMsid)
        {
                if(!mapMsAi.containskey(PM))
                {
                        List<Action_Item__c> lstAction = new List<Action_Item__c>();                        
                        mapMsAi.put(PM,lstAction);
                }
        }
    }
}