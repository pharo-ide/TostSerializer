operations
readObjectWith: aTostMaterialization

	| objectFormatType currentFormat |
	
	objectFormatType := aTostMaterialization readByte.	
	currentFormat := formats at: objectFormatType.
	
	^currentFormat readObjectWith: aTostMaterialization