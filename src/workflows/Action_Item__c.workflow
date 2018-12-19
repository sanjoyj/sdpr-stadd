<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Action_Due_date_Notification</fullName>
        <description>Action Due date Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Activity_due_by_today</template>
    </alerts>
    <rules>
        <fullName>Action Due date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Action_Item__c.Bring_Forward__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Action_Item__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Complete,No Longer Required,Owner Change</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Action_Due_date_Notification</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Action_Item__c.Bring_Forward_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
