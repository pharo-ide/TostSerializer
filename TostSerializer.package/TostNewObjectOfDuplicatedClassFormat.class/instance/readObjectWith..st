operations
readObjectWith: aTostMaterialization 
	| classIndex class |
	classIndex := aTostMaterialization readPositiveInteger.
	
	class := aTostMaterialization processedClassAt: classIndex.	
	^aTostMaterialization readNewObjectOf: class