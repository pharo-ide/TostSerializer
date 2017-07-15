writing-objects
writeDuplicatedClass: aClass format: formatId

	processedClasses 
		at: aClass ifPresent: [:index |
			self writeObjectIndex: index format: formatId.
			^true]
		ifAbsentPut: objectIndex.
		
	^false