operations
readObjectWith: aTostMaterialization 
	| objectIndex |
	objectIndex := aTostMaterialization readPositiveInteger.
	
	^aTostMaterialization processedObjectAt: objectIndex