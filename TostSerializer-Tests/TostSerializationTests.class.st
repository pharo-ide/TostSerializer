Class {
	#name : #TostSerializationTests,
	#superclass : #TostTransportTestCase,
	#instVars : [
		'binaryData'
	],
	#category : #'TostSerializer-Tests'
}

{ #category : #helpers }
TostSerializationTests >> binaryData [
	^binaryData := transportStream contents.
	
]

{ #category : #helpers }
TostSerializationTests >> clearData [
	transportStream reset
]

{ #category : #running }
TostSerializationTests >> createTransportStream [
	transportStream := ByteArray new writeStream
]

{ #category : #'tests-objects' }
TostSerializationTests >> testByteArrayInstance [

	| object |
	object := #[1 2 5 10].
	transporter serialize: object.
	self clearData.
	transporter serialize: object copy.
	
	self binaryData should equal: {
		transport formatIdFor: TostNewObjectOfDuplicatedClassFormat. 
		1. 0. "two bytes to encode 0 int which is index for duplicated ByteArray class" 
		1. 4 "two bytes to encode 4 int which is size of given byte array"
	} asByteArray, object
]

{ #category : #'tests-objects' }
TostSerializationTests >> testEmptyObject [

	| object classNameBytes classNameSizeBytes |
	object := Object new.
	transporter serialize: object.
	classNameBytes := Object name asByteArray.
	classNameSizeBytes := #[1], classNameBytes size asByteArray.
	
	self binaryData should equal: ({transport formatIdFor: TostNewObjectOfNewClassFormat}, classNameSizeBytes, classNameBytes) asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testObjectAndItClass [

	| object |
	object := Object new.
	transporter writeBytes: #[ 1 2 3 4 ].
	transporter serialize: Object new.
	self clearData.
	transporter writeObject: Object.
	
	self binaryData first should equal: (transport formatIdFor: TostNewObjectOfNewClassFormat)
]

{ #category : #'tests-objects' }
TostSerializationTests >> testObjectOfWellKnownClass [

	| extraFormat |
	extraFormat := TostNewObjectOfWellKnownClassFormat on: { Point. Object. Array }.
	transport addFirstFormat: extraFormat.
	
	transporter serialize: Object new.
	
	self binaryData should equal: {extraFormat id. 2} asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testSameObjectTwice [

	| object |
	object := Object new.
	transporter writeBytes: #[1 2 3 4]. "index of following object should be equal stream position (4)"
	transporter serialize: object.
	self clearData.
	transporter serialize: object.
	
	self binaryData should equal: ({transport formatIdFor: TostDuplicatedObjectFormat}, #[1 4]) asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testThreeObjectsOfSameClassWhereFirstTwoAreSame [

	| object |
	object := Object new.
	transporter writeBytes: #[ 1 2 3 4 ].
	transporter serialize: object.
	transporter serialize: object.
	self clearData.
	transporter serialize: Object new.
	
	self binaryData should equal: {transport formatIdFor: TostNewObjectOfDuplicatedClassFormat. 1. 4} asByteArray 
]

{ #category : #'tests-objects' }
TostSerializationTests >> testThreeObjectsOfSameClassWhereLastTwoAreSame [

	| object objectIndex |
	object := Object new.
	transporter writeBytes: #[ 1 2 3 4 ].
	transporter serialize: Object new.
	objectIndex := transporter transportStream position.
	transporter serialize: object.
	self clearData.
	transporter serialize: object.
	
	self binaryData should equal: {transport formatIdFor: TostDuplicatedObjectFormat. 1. objectIndex} asByteArray 
]

{ #category : #'tests-objects' }
TostSerializationTests >> testTwoObjectsOfSameClass [

	| object |
	object := Object new.
	transporter writeBytes: #[ 1 2 3 4 ].
	transporter serialize: Object new.
	self clearData.

	transporter serialize: Object new.
	
	self binaryData should equal: {transport formatIdFor: TostNewObjectOfDuplicatedClassFormat. 1. 4} asByteArray 
]

{ #category : #'tests-objects' }
TostSerializationTests >> testWellKnownCompositeObject [

	| extraFormat object container |
	object := TostTestContainer with: 300.
	container := TostTestContainer with: object.
	transport addFirstFormat: (TostNewObjectOfWellKnownClassFormat on: {TostTestContainer}).
	extraFormat := TostWellKnownObjectFormat on: {2@3. object. 10@30 }.
	transport addFirstFormat: extraFormat.
	transporter serialize: container.
	
	self binaryData should equal: {2. 1. extraFormat id. 2} asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testWellKnownEmptyObject [

	| extraFormat object |
	object := Object new.
	extraFormat := TostWellKnownObjectFormat on: {2@3. object. 10@30 }.
	transport addFirstFormat: extraFormat.
	
	transporter serialize: object.
	
	self binaryData should equal: {extraFormat id. 2} asByteArray
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingByteArray [

	transporter writeBytes: #[1 2 3].
	
	self binaryData should equal: #[1 2 3]
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingOneByteInteger [

	transporter writeInteger: 10.
	
	self binaryData should equal: #[1 0 10]
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingTwoBytesInteger [
	transporter writeInteger: 300.
	self binaryData should equal: {2. 0. (300 byteAt: 2). (300 byteAt: 1)} asByteArray
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingTwoBytesNegativeInteger [
	transporter writeInteger: -300.
	self binaryData should equal: {2. 1. (300 byteAt: 2). (300 byteAt: 1)} asByteArray
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingTwoBytesPositiveInteger [
	transporter writePositiveInteger: 300.
	self binaryData should equal: {2. (300 byteAt: 2). (300 byteAt: 1)} asByteArray
]
