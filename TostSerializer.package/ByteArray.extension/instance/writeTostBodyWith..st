*TostSerializer
writeTostBodyWith: aTostSerialization
	super writeTostBodyWith: aTostSerialization.
	aTostSerialization writeBytes: self