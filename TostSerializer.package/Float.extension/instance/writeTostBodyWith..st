*TostSerializer
writeTostBodyWith: aTostSerialization

	aTostSerialization
		writePositiveInteger:  (self at: 1);
		writePositiveInteger:  (self at: 2)