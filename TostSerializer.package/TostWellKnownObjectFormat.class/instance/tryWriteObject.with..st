operations
tryWriteObject: anObject with: aTostSerialization
	
	| written |
	written := super tryWriteObject: anObject with: aTostSerialization.
	written ifTrue: [ aTostSerialization skip: anObject].
	^written