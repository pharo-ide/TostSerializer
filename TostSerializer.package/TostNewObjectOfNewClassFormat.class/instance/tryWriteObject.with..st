operations
tryWriteObject: anObject with: aTostSerialization

	aTostSerialization writeObjectClass: anObject class format: id.
	anObject writeTostBodyWith: aTostSerialization.
	^true