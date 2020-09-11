"
I am most general object format.
I encode objects by writing full class name on stream at begining and the rest of bytes at the end. Rest of bytes are binary representation of object body according to there logic. Objects implement it in method ""writeTostBodyWith: aTostTransporter""
"
Class {
	#name : #TostNewObjectOfNewClassFormat,
	#superclass : #TostFormat,
	#category : #TostSerializer
}

{ #category : #operations }
TostNewObjectOfNewClassFormat >> readObjectWith: aTostTransporter [

	^aTostTransporter readNewClassAndObject
]

{ #category : #operations }
TostNewObjectOfNewClassFormat >> tryWriteObject: anObject with: aTostTransporter [

	aTostTransporter writeObjectClass: anObject class format: id.
	anObject writeTostBodyWith: aTostTransporter.
	^true
]
