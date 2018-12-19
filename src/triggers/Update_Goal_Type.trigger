trigger Update_Goal_Type on Plan_Goal__c (before insert,before update) {
{
    for (Plan_Goal__c objGoal : Trigger.new)
    {
        if (objGoal.Goal_Type__c != null && objGoal.Goal_Type__c != 'Other')               
        {
            objGoal.Name = objGoal.Goal_Type__c;
        }
    }
}
}