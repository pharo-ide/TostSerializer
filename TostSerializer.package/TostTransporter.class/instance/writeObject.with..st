operations
writeObject: anObject with: aTostSerialization
	| success |
	formats do: [ :each | 		 
		success := each tryWriteObject: anObject with: aTostSerialization.
		success ifTrue: [ ^true ] ].
	
	^false