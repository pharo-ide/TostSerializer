Class {
	#name : #TostSerializationTests,
	#superclass : #TostTransporterTestCase,
	#instVars : [
		'serialization',
		'dataStream',
		'binaryData'
	],
	#category : #'TostSerializer-Tests'
}

{ #category : #helpers }
TostSerializationTests >> binaryData [
	^binaryData := dataStream contents.
	
]

{ #category : #helpers }
TostSerializationTests >> clearData [
	dataStream reset
]

{ #category : #running }
TostSerializationTests >> setUp [
	super setUp.
	
	dataStream := ByteArray new writeStream.
	serialization := TostSerialization by: transporter on: dataStream
]

{ #category : #'tests-objects' }
TostSerializationTests >> testByteArrayInstance [

	| object |
	object := #[1 2 5 10].
	serialization serialize: object.
	self clearData.
	serialization serialize: object copy.
	
	self binaryData should equal: {
		transporter formatIdFor: TostNewObjectOfDuplicatedClassFormat. 
		1. 0. "two bytes to encode 0 int which is index for duplicated ByteArray class" 
		1. 4 "two bytes to encode 4 int which is size of given byte array"
	} asByteArray, object
]

{ #category : #'tests-objects' }
TostSerializationTests >> testEmptyObject [

	| object classNameBytes classNameSizeBytes |
	object := Object new.
	serialization serialize: object.
	classNameBytes := Object name asByteArray.
	classNameSizeBytes := #[1], classNameBytes size asByteArray.
	
	self binaryData should equal: ({transporter formatIdFor: TostNewObjectOfNewClassFormat}, classNameSizeBytes, classNameBytes) asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testObjectAndItClass [

	| object |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: Object new.
	self clearData.
	serialization writeObject: Object.
	
	self binaryData first should equal: (transporter formatIdFor: TostNewObjectOfNewClassFormat)
]

{ #category : #'tests-objects' }
TostSerializationTests >> testObjectOfWellKnownClass [

	| extraFormat |
	extraFormat := TostNewObjectOfWellKnownClassFormat on: { Point. Object. Array }.
	transporter addFirstFormat: extraFormat.
	
	serialization serialize: Object new.
	
	self binaryData should equal: {extraFormat id. 2} asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testSameObjectTwice [

	| object |
	object := Object new.
	serialization writeBytes: #[1 2 3 4]. "index of following object should be equal stream position (4)"
	serialization serialize: object.
	self clearData.
	serialization serialize: object.
	
	self binaryData should equal: ({transporter formatIdFor: TostDuplicatedObjectFormat}, #[1 4]) asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testThreeObjectsOfSameClassWhereFirstTwoAreSame [

	| object |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: object.
	serialization serialize: object.
	self clearData.
	serialization serialize: Object new.
	
	self binaryData should equal: {transporter formatIdFor: TostNewObjectOfDuplicatedClassFormat. 1. 4} asByteArray 
]

{ #category : #'tests-objects' }
TostSerializationTests >> testThreeObjectsOfSameClassWhereLastTwoAreSame [

	| object objectIndex |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: Object new.
	objectIndex := serialization dataPosition.
	serialization serialize: object.
	self clearData.
	serialization serialize: object.
	
	self binaryData should equal: {transporter formatIdFor: TostDuplicatedObjectFormat. 1. objectIndex} asByteArray 
]

{ #category : #'tests-objects' }
TostSerializationTests >> testTwoObjectsOfSameClass [

	| object |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: Object new.
	self clearData.

	serialization serialize: Object new.
	
	self binaryData should equal: {transporter formatIdFor: TostNewObjectOfDuplicatedClassFormat. 1. 4} asByteArray 
]

{ #category : #'tests-objects' }
TostSerializationTests >> testWellKnownCompositeObject [

	| extraFormat object container |
	object := TostTestContainer with: 300.
	container := TostTestContainer with: object.
	transporter addFirstFormat: (TostNewObjectOfWellKnownClassFormat on: {TostTestContainer}).
	extraFormat := TostWellKnownObjectFormat on: {2@3. object. 10@30 }.
	transporter addFirstFormat: extraFormat.
	serialization serialize: container.
	
	self binaryData should equal: {2. 1. extraFormat id. 2} asByteArray
]

{ #category : #'tests-objects' }
TostSerializationTests >> testWellKnownEmptyObject [

	| extraFormat object |
	object := Object new.
	extraFormat := TostWellKnownObjectFormat on: {2@3. object. 10@30 }.
	transporter addFirstFormat: extraFormat.
	
	serialization serialize: object.
	
	self binaryData should equal: {extraFormat id. 2} asByteArray
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingByteArray [

	serialization writeBytes: #[1 2 3].
	
	self binaryData should equal: #[1 2 3]
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingOneByteInteger [

	serialization writeInteger: 10.
	
	self binaryData should equal: #[1 0 10]
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingTwoBytesInteger [
	serialization writeInteger: 300.
	self binaryData should
		equal:
			{2.
			0.
			(300 byteAt: 2).
			(300 byteAt: 1)} asByteArray
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingTwoBytesNegativeInteger [
	serialization writeInteger: -300.
	self binaryData should
		equal:
			{2.
			1.
			(300 byteAt: 2).
			(300 byteAt: 1)} asByteArray
]

{ #category : #'tests-primitive data' }
TostSerializationTests >> testWritingTwoBytesPositiveInteger [
	serialization writePositiveInteger: 300.
	self binaryData should
		equal:
			{2.
			(300 byteAt: 2).
			(300 byteAt: 1)} asByteArray
]
