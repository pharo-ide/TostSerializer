operations
readObjectWith: aTostMaterialization 
	| class classIndex |
	classIndex := aTostMaterialization readByte.
	class := objects at: classIndex.
	
	^aTostMaterialization readNewObjectOf: class