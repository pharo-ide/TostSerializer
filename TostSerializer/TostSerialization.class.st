"
I implement object serialization.

I use object traveler to enumerate all object references and write them on stream in order according to transporter formats.
I implement low level encoding methods like writeInteger: or #writeBytes: which are used for specific objects serialization.
Objects manage binary encoding in method:
	writeTostBodyWith: aSerialization
 
My processedObject dictionary contains all serialized objects as keys and indexes inside stream as values.
My processedClasses dictionary contains all classes of serialized objects as keys and indexes inside stream as values.

Public API and Key Messages

- serialize: anObject
"
Class {
	#name : #TostSerialization,
	#superclass : #TostTransportation,
	#category : 'TostSerializer'
}

{ #category : #api }
TostSerialization >> serialize: anObject [

	traveler := ObjectTraveler on: anObject.
	
	self writeNextObject: anObject.	
		
	traveler referencesDo: [ :each | 
		self writeNextObject: each ]
]

{ #category : #'writing-primitive data' }
TostSerialization >> writeByte: aByte [

	dataStream nextPut: aByte
]

{ #category : #'writing-primitive data' }
TostSerialization >> writeBytes: aByteArray [
	
	dataStream nextPutAll: aByteArray 
]

{ #category : #'writing-objects' }
TostSerialization >> writeDuplicatedClass: aClass format: formatId [

	processedClasses 
		at: aClass ifPresent: [:index |
			self writeObjectIndex: index format: formatId.
			^true]
		ifAbsentPut: objectIndex.
		
	^false
]

{ #category : #'writing-objects' }
TostSerialization >> writeDuplicatedObject: anObject format: formatId [

	anObject isTostValueObject ifTrue: [ ^false ].
	
	processedObjects 
		at: anObject ifPresent: [:index |
			self writeObjectIndex: index format: formatId.
			^true]
		ifAbsentPut: objectIndex.

	^false
]

{ #category : #'writing-primitive data' }
TostSerialization >> writeInteger: anInteger [
	| bytesSize |
	bytesSize := anInteger bytesCount.
	bytesSize > 255
		ifTrue: [ self error: 'Too big integer is not supported' ].
	dataStream nextPut: bytesSize.
	dataStream
		nextPut:
			(anInteger < 0
				ifTrue: [ 1 ]
				ifFalse: [ 0 ]).
	bytesSize to: 1 by: -1 do: [ :i | dataStream nextPut: (anInteger byteAt: i) ]
]

{ #category : #'writing-objects' }
TostSerialization >> writeNextObject: anObject [
	objectIndex := self dataPosition.
	self writeObject: anObject
]

{ #category : #'writing-objects' }
TostSerialization >> writeObject: anObject [

	^transporter writeObject: anObject with: self
]

{ #category : #'writing-objects' }
TostSerialization >> writeObjectClass: aClass format: binaryType [
	
	dataStream nextPut: binaryType.
	aClass name isByteString
		ifFalse: [ self error: 'Only classes with bytestring names are supported' ].
		
	self writeString: aClass name
]

{ #category : #'writing-objects' }
TostSerialization >> writeObjectIndex: objectIdInteger format: binaryTypeByte [

	dataStream nextPut: binaryTypeByte.
	self writePositiveInteger: objectIdInteger 
]

{ #category : #'writing-primitive data' }
TostSerialization >> writePositiveInteger: anInteger [
	| bytesSize |
	anInteger < 0
		ifTrue: [ self error: 'Given int should be positive' ].
	bytesSize := anInteger bytesCount.
	bytesSize > 255
		ifTrue: [ self error: 'Too big integer is not supported' ].
	dataStream nextPut: bytesSize.
	bytesSize to: 1 by: -1 do: [ :i | dataStream nextPut: (anInteger byteAt: i) ]
]

{ #category : #'writing-objects' }
TostSerialization >> writeSmallObjectIndex: objectIdByte format: binaryTypeByte [

	dataStream nextPut: binaryTypeByte.
	dataStream nextPut: objectIdByte
]

{ #category : #'writing-primitive data' }
TostSerialization >> writeString: aString [
	
	| bytes |
	bytes := aString asByteArray.
	self writePositiveInteger: bytes size.
	dataStream nextPutAll: bytes
]

{ #category : #'writing-objects' }
TostSerialization >> writeSubstitution: substitutionObject for: anObject format: formatId [

	self writeByte: formatId.
	self writeObject: substitutionObject.
	self atNextStepProcess: substitutionObject.
	self skip: anObject
]
