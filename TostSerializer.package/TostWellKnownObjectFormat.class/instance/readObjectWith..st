operations
readObjectWith: aTostMaterialization 
	| objectIndex |
	objectIndex := aTostMaterialization readByte.
	^objects at: objectIndex