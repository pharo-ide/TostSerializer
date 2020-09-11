"
I am format for objects which belongs to well known classes. 
I encode such objects in the way where classes are encoded by one byte index instead of full name.
For example you could create compact format for nil, true and false:

	TostNewObjectOfWellKnownClassFormat on: { Array. OrderedCollection. String}. 

Number of well known classes is restricted to 255
"
Class {
	#name : #TostNewObjectOfWellKnownClassFormat,
	#superclass : #TostIndexedObjectFormat,
	#category : 'TostSerializer'
}

{ #category : #operations }
TostNewObjectOfWellKnownClassFormat >> readObjectWith: aTostTransporter [ 
	| class classIndex |
	classIndex := aTostTransporter readByte.
	class := objects at: classIndex.
	
	^aTostTransporter readNewObjectOf: class
]

{ #category : #operations }
TostNewObjectOfWellKnownClassFormat >> tryWriteObject: anObject with: aTostTransporter [
	
	| written |
	written := super tryWriteObject: anObject class with: aTostTransporter.
	written ifTrue: [ anObject writeTostBodyWith: aTostTransporter ].
	^written
]
