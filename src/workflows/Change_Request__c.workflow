<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Change_Request_Approved_Email</fullName>
        <description>Change Request Approved Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BME_Templates/Change_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>Change_Request_Rejected_Email</fullName>
        <description>Change Request Rejected Email</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BME_Templates/Change_Request_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Request_Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Change Request Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Request_Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Denied</literalValue>
        <name>Change Request Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Request_submitted_for_approval</fullName>
        <field>Status__c</field>
        <literalValue>Submitted for approval</literalValue>
        <name>Change Request submitted for approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
