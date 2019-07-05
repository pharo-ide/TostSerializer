"
I am format for well known objects. I encode them by one byte index and manage serialization process to skip all internal structure.
For example you could create compact format for nil, true and false:

	TostWellKnownObjectFormat on: { nil. true. false} 

There is similar default instance on class side.

Number of well known objects is restricted to 255
"
Class {
	#name : #TostWellKnownObjectFormat,
	#superclass : #TostIndexedObjectFormat,
	#classInstVars : [
		'default'
	],
	#category : 'TostSerializer'
}

{ #category : #accessing }
TostWellKnownObjectFormat class >> default [
	^default ifNil: [ default := TostWellKnownObjectFormat on: { nil. true. false. 0. 1 }]
]

{ #category : #operations }
TostWellKnownObjectFormat >> readObjectWith: aTostMaterialization [ 
	| objectIndex |
	objectIndex := aTostMaterialization readByte.
	^objects at: objectIndex
]

{ #category : #operations }
TostWellKnownObjectFormat >> tryWriteObject: anObject with: aTostSerialization [
	
	| written |
	written := super tryWriteObject: anObject with: aTostSerialization.
	written ifTrue: [ aTostSerialization skip: anObject].
	^written
]
