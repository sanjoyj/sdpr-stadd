<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_when_referral_is_converted_to_a_case</fullName>
        <description>Notify when referral is converted to a case</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Case_converted_notification</template>
    </alerts>
    <alerts>
        <fullName>Notify_when_referral_is_rejected</fullName>
        <description>Notify when referral is rejected</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderAddress>stadd_support@gov.bc.ca</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Referral_rejected_notification_V2</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Owner_to_Coastal_Region</fullName>
        <field>OwnerId</field>
        <lookupValue>Coastal_Region</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Owner to Coastal Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Owner_to_Interior_Region</fullName>
        <field>OwnerId</field>
        <lookupValue>Interior_Region</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Owner to Interior Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Owner_to_Northern_Region</fullName>
        <field>OwnerId</field>
        <lookupValue>Northern_Region</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Owner to Northern Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Owner_to_Vancouver_Coastal_Region</fullName>
        <field>OwnerId</field>
        <lookupValue>Vancouver_Coastal_Region</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Owner to Vancouver Coastal Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Owner_to_Vancouver_Island_Region</fullName>
        <field>OwnerId</field>
        <lookupValue>Vancouver_Island_Region</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change Owner to Vancouver Island Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_RT_from_Partner_to_Standard</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Standard</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change RT from Partner to Standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_referral_Record_type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change referral Record type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_referral_Record_type_to_standard</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Standard</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Change referral Record type (to standard</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Fraser_Region_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Fraser_Region</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Fraser Region Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign Referral to Coastal Region Queue</fullName>
        <actions>
            <name>Change_Owner_to_Coastal_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Burnaby</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Referral to Fraser Region Queue</fullName>
        <actions>
            <name>Change_RT_from_Partner_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_to_Fraser_Region_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5 OR 6 OR 7 OR 8 OR 9 OR 10 OR 11 OR 12 OR 13</booleanFilter>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Surrey East</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Langley</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Delta</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Burnaby</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Surrey North</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Surrey South</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Abbotsford</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>New Westminster</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Ridge Meadows</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Tri-Cities</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Chilliwack</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Mission</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Fraser / Cascades</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Referral to Interior Region Queue</fullName>
        <actions>
            <name>Change_Owner_to_Interior_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Change_RT_from_Partner_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5</booleanFilter>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>South Okanagan</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Kamloops</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Cariboo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Gold Trail</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>East Kootenay</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Referral to Northern Region Queue</fullName>
        <actions>
            <name>Change_Owner_to_Northern_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Change_RT_from_Partner_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5 OR 6</booleanFilter>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Haida Gwaii / Prince Rupert</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Bulkley / Stikine</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Prince George</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Nechako Lakes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Peace North</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Quesnel</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Referral to Vancouver Coastal Region Queue</fullName>
        <actions>
            <name>Change_Owner_to_Vancouver_Coastal_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Change_RT_from_Partner_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>City Centre</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Downtown Eastside</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assign Referral to Vancouver Island Region Queue</fullName>
        <actions>
            <name>Change_Owner_to_Vancouver_Island_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Change_RT_from_Partner_to_Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 Or 4</booleanFilter>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Nanaimo</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Parksville / Qualicum</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Comox Valley</value>
        </criteriaItems>
        <criteriaItems>
            <field>Referral__c.EIS_Location__c</field>
            <operation>equals</operation>
            <value>Campbell River</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change referral to read-only</fullName>
        <actions>
            <name>Change_referral_Record_type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Referral__c.Status__c</field>
            <operation>equals</operation>
            <value>Case Created,Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Inform referring person when Referral is converted to a case</fullName>
        <actions>
            <name>Notify_when_referral_is_converted_to_a_case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Referral__c.Status__c</field>
            <operation>equals</operation>
            <value>Case Created</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Inform referring person when Referral is rejected</fullName>
        <actions>
            <name>Notify_when_referral_is_rejected</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Referral__c.Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Revert back the referral from read-only</fullName>
        <actions>
            <name>Change_referral_Record_type_to_standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Referral__c.Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
