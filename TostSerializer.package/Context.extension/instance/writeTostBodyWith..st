*TostSerializer
writeTostBodyWith: aTostSerialization

	aTostSerialization writeByte: Smalltalk wordSize.
	aTostSerialization writeByte: self method frameSize