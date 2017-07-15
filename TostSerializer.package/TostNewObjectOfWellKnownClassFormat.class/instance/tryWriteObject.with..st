operations
tryWriteObject: anObject with: aTostSerialization
	
	| written |
	written := super tryWriteObject: anObject class with: aTostSerialization.
	written ifTrue: [ anObject writeTostBodyWith: aTostSerialization ].
	^written