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
TostNewObjectOfWellKnownClassFormat >> readObjectWith: aTostMaterialization [ 
	| class classIndex |
	classIndex := aTostMaterialization readByte.
	class := objects at: classIndex.
	
	^aTostMaterialization readNewObjectOf: class
]

{ #category : #operations }
TostNewObjectOfWellKnownClassFormat >> tryWriteObject: anObject with: aTostSerialization [
	
	| written |
	written := super tryWriteObject: anObject class with: aTostSerialization.
	written ifTrue: [ anObject writeTostBodyWith: aTostSerialization ].
	^written
]
