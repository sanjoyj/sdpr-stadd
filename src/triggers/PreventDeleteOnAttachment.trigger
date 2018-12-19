trigger PreventDeleteOnAttachment on Attachment (before delete) {
	for (Attachment D: trigger.old)
	{
		List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
		String MyProflieName = PROFILE[0].Name;
		if(  MyProflieName !='System Administrator')
		{
			D.adderror( 'Only a System Administrator can delete documents' );
		}
	}

}