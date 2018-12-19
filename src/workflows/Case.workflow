<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Coastal_Region_Transfer</fullName>
        <description>Coastal Region Transfer</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_Coastal_Region</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Transfer_Queue</template>
    </alerts>
    <alerts>
        <fullName>Fraser_Region_Transfer</fullName>
        <description>Fraser Region Transfer</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_Fraser_Region</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Transfer_Queue</template>
    </alerts>
    <alerts>
        <fullName>Interior_Region_Transfer</fullName>
        <description>Interior Region Transfer</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_Interior_Region</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Transfer_Queue</template>
    </alerts>
    <alerts>
        <fullName>Northern_Region_Transfer</fullName>
        <description>Northern Region Transfer</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_Northern_Region</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Transfer_Queue</template>
    </alerts>
    <alerts>
        <fullName>Vancouver_Coastal_Region_Transfer</fullName>
        <description>Vancouver Coastal Region Transfer</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_Fraser_Region</recipient>
            <type>role</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Transfer_Queue</template>
    </alerts>
    <alerts>
        <fullName>Vancouver_Island_Transfer</fullName>
        <description>Vancouver Island Transfer</description>
        <protected>false</protected>
        <recipients>
            <recipient>Director_Vancouver_Island_Region</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Transfer_Queue</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_the_record_type_of_case</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Standard</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change the record type of case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_RT_to_Closed</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Closed</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update RT to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Unique_field</fullName>
        <description>Update Unique field on Case</description>
        <field>UniqueRec__c</field>
        <formula>(Contact.FirstName) + Contact.LastName + 
TEXT( Contact.Birthdate )</formula>
        <name>Update Unique field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Unique_field_plan</fullName>
        <description>Update Unique field for Plan</description>
        <field>UniqueRec__c</field>
        <formula>Contact.FirstName +  Contact.LastName + TEXT( Contact.Birthdate )</formula>
        <name>Update Unique field Plan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>date_referred_timestamp</fullName>
        <field>Date_Referred__c</field>
        <formula>TODAY()</formula>
        <name>date referred timestamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_the_referral_accepted_date</fullName>
        <field>Date_referral_accepted__c</field>
        <formula>TODAY()</formula>
        <name>update the referral accepted date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Coastal Region Transfer</fullName>
        <actions>
            <name>Coastal_Region_Transfer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Coastal Region Transfer In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fraser Region Transfer</fullName>
        <actions>
            <name>Fraser_Region_Transfer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Fraser Region Transfer In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Interior Region Transfer</fullName>
        <actions>
            <name>Interior_Region_Transfer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Interior Region Transfer In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Northern Region Transfer</fullName>
        <actions>
            <name>Northern_Region_Transfer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Northern Region Transfer In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Referred date timestamp</fullName>
        <actions>
            <name>date_referred_timestamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Pending Approval</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Unique field Case</fullName>
        <actions>
            <name>Update_Unique_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Unique field per individual</description>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Vancouver Coastal Region Transfer</fullName>
        <actions>
            <name>Vancouver_Coastal_Region_Transfer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Vancouver Coastal Region Transfer In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Vancouver Island Transfer</fullName>
        <actions>
            <name>Vancouver_Island_Transfer</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>Vancouver Island Region Transfer In</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>When Case Status is Closed%2C Update RT</fullName>
        <actions>
            <name>Update_RT_to_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
