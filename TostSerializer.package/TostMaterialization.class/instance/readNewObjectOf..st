reading-objects
readNewObjectOf: aClass

	| newObject |
	newObject := aClass createTostInstanceWith: self.
	newObject isTostValueObject ifFalse: [ 
		processedObjects at: objectIndex put: newObject].
	^newObject