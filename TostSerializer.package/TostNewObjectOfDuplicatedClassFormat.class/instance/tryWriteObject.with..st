operations
tryWriteObject: anObject with: aTostSerialization

	| written |
	written := aTostSerialization writeDuplicatedClass: anObject class format: id.
	
	written ifTrue: [ anObject writeTostBodyWith: aTostSerialization].
	
	^written