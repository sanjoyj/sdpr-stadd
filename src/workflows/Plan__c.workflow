<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Unique_Case_Plan_Field_Update</fullName>
        <description>Unique Case Plan Field Update</description>
        <field>Unique_Case_Plan__c</field>
        <formula>Case__r.Id +  Name</formula>
        <name>Unique Case Plan Field Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Unique_field_on_Plan</fullName>
        <description>Update Unique field on Plan</description>
        <field>ONLY_ONE_PLAN_PER_PERSON_ALLOWED__c</field>
        <formula>IF( ISPICKVAL(Plan_Type__c, &apos;Support Plan&apos;), Case__r.Id + TEXT(Plan_Type__c), Case__r.Id+ TEXT(CreatedDate))</formula>
        <name>Update Unique field on Plan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Unique Case Plan Field Update</fullName>
        <actions>
            <name>Unique_Case_Plan_Field_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Plan__c.Plan_Type__c</field>
            <operation>equals</operation>
            <value>Support Plan</value>
        </criteriaItems>
        <description>Unique Case Plan Field Update</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Unique field Plan</fullName>
        <actions>
            <name>Update_Unique_field_on_Plan</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Update Unique field Plan</description>
        <formula>ISCHANGED(Plan_Type__c) || ISNEW()</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
