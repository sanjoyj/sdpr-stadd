<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Deliverable_Approved_Email</fullName>
        <description>Deliverable Approved Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BME_Templates/Deliverable_Approved</template>
    </alerts>
    <alerts>
        <fullName>Deliverable_Rejected_Email</fullName>
        <description>Deliverable Rejected Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BME_Templates/Deliverable_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Escalation_Email_Alert</fullName>
        <description>Escalation Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Escalate_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BME_Templates/Project_Item_Escalated</template>
    </alerts>
    <fieldUpdates>
        <fullName>Deliverable_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Deliverable Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deliverable_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Deliverable Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Deliverable_submitted_for_approval</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Deliverable submitted for approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Close_Date_when_status_is_Clo</fullName>
        <description>Updates Close Date field with Last modified date when Status of the Open Item is set to Closed or Resolved</description>
        <field>Close_Date__c</field>
        <formula>LastModifiedDate</formula>
        <name>Update Close Date when status is Clo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email for Escalation</fullName>
        <actions>
            <name>Escalation_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project_Item__c.Escalate_To__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This Workflow will be used to send an email to the person when a project item is escalated to him/her.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Close Date</fullName>
        <actions>
            <name>Update_Close_Date_when_status_is_Clo</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will update the Close Date on an Open Item to the Last Modified date, if the status has been updated to Closed or Resolved</description>
        <formula>NOT( ISPICKVAL(PRIORVALUE( Status__c), &quot;Closed&quot;) ||  ISPICKVAL(PRIORVALUE( Status__c), &quot;Resolved&quot;) || ISPICKVAL(PRIORVALUE( Status__c), &quot;Approved&quot;)) &amp;&amp; (ISPICKVAL( Status__c, &quot;Closed&quot;) || ISPICKVAL( Status__c, &quot;Resolved&quot;) || ISPICKVAL( Status__c, &quot;Approved&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
