operations
readObjectWith: aTostMaterialization
	| object |
	object := aTostMaterialization readObject.
	aTostMaterialization atNextStepProcess: object.
	^object