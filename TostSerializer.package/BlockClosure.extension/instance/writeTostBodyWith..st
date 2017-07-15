*TostSerializer
writeTostBodyWith: aTostSerialization
	super writeTostBodyWith: aTostSerialization.
	
	aTostSerialization writeByte: Smalltalk wordSize