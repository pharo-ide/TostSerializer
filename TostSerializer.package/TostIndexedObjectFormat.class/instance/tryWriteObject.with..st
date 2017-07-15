operations
tryWriteObject: anObject with: aTostSerialization
	
	indexes 
		at: anObject ifPresent: [:index |
			aTostSerialization writeSmallObjectIndex: index format: id.
			^true]
		ifAbsent: [^false].
		
	^false