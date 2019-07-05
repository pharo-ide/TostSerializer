"
I am most general object format.
I encode objects by writing full class name on stream at begining and the rest of bytes at the end. Rest of bytes are binary representation of object body according to there logic. Objects implement it in method ""writeTostBodyWith: aSerialization""
"
Class {
	#name : #TostNewObjectOfNewClassFormat,
	#superclass : #TostFormat,
	#category : 'TostSerializer'
}

{ #category : #operations }
TostNewObjectOfNewClassFormat >> readObjectWith: aTostMaterialization [

	^aTostMaterialization readNewClassAndObject
]

{ #category : #operations }
TostNewObjectOfNewClassFormat >> tryWriteObject: anObject with: aTostSerialization [

	aTostSerialization writeObjectClass: anObject class format: id.
	anObject writeTostBodyWith: aTostSerialization.
	^true
]
