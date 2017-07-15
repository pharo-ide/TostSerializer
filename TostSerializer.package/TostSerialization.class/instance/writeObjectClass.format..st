writing-objects
writeObjectClass: aClass format: binaryType
	
	dataStream nextPut: binaryType.
	aClass name isByteString
		ifFalse: [ self error: 'Only classes with bytestring names are supported' ].
		
	self writeString: aClass name