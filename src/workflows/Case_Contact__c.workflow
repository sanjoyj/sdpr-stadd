<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_to_Potential_Portal_user</fullName>
        <description>Email to Potential Portal user</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Person_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Email_to_Potential_Portal_user_HTML</template>
    </alerts>
    <fieldUpdates>
        <fullName>Case_Contact_Date_Null</fullName>
        <description>when case contact inactive flag is not checked</description>
        <field>Inactive_Date__c</field>
        <name>Case_Contact_Date_Null</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Contact_Today</fullName>
        <description>Insert today&apos;s date in Case Contact&apos;s Inactive date</description>
        <field>Inactive_Date__c</field>
        <formula>Today()</formula>
        <name>Case_Contact_Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Portal_Invite_Date</fullName>
        <description>Update Portal Invite Date</description>
        <field>Portal_Invite_Date__c</field>
        <formula>Now()</formula>
        <name>Update Portal Invite Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Case_Contact_Inactive_Checked</fullName>
        <actions>
            <name>Case_Contact_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case_Contact__c.Inactive__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case_Contact__c.Inactive_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>When Inactive is checked, the date field should auto populate to today&apos;s date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case_Contact_Inactive_Unchecked</fullName>
        <actions>
            <name>Case_Contact_Date_Null</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case_Contact__c.Inactive__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>When Inactive is unchecked, the date field should clear</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send email to the Case Contact</fullName>
        <actions>
            <name>Email_to_Potential_Portal_user</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Portal_Invite_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case_Contact__c.Portal_Invite__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send email to the Case Contact</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
