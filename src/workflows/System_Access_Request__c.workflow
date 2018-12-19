<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>System_Access_Approved</fullName>
        <ccEmails>stadd_support@gov.bc.ca</ccEmails>
        <description>System Access Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/System_Access_Request_Approved</template>
    </alerts>
    <rules>
        <fullName>System Access Request Approved</fullName>
        <actions>
            <name>System_Access_Approved</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>System_Access_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
