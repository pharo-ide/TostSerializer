writing-objects
writeDuplicatedObject: anObject format: formatId

	anObject isTostValueObject ifTrue: [ ^false ].
	
	processedObjects 
		at: anObject ifPresent: [:index |
			self writeObjectIndex: index format: formatId.
			^true]
		ifAbsentPut: objectIndex.

	^false