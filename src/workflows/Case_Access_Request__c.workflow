<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Case_Access_Request_granted</fullName>
        <description>Case Access Request granted</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/New_Case_Access_Request_Granted</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Owner_to_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Pending_Case_Access_Requests</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Owner to Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Case Access Request granted</fullName>
        <actions>
            <name>Case_Access_Request_granted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case_Access_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Granted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pending Case Access Requests</fullName>
        <actions>
            <name>Change_Owner_to_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case_Access_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
