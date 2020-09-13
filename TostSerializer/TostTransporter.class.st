"
I implement object serialization and materialization through given transport stream using defined transport format:

	transporter := TostTransporter using: aTostTransport on: transportStream. 

My instances are created for transportation of every object passed into given TostTransport: 

	transport newTransporterOn: transportStream 
	
Depending on the type of given stream (write or stream) I should be used to execute concrete transport operation (serialization or materialization).

1. The serialization of objects into a stream is driven by object traveler which enumerates all object references step by step.
During traversal each reference is written into the stream according to defined transport formats.

I implement low level encoding methods like writeInteger: or #writeBytes: which are used for specific objects serialization.
Objects manage binary encoding in the method:
	writeTostBodyWith: aTostTransporter
 
During serialization #processedObject dictionary contains all serialized objects as keys and indexes inside stream as values.
And #processedClasses dictionary contains all classes of serialized objects as keys and indexes inside stream as values.

To write full object use #serializeObject: message.

2. The materialization of objects from stream is performed step by step. First I read a root and start iterate references by object traveler. For each reference (which are nil from the begining) I read next object from the stream and assign it to current reference. Object travel iterates in breadth first direction. So at some point it will go deeply to next read object which will be materialized in same way as the root. This loop will continue until traveler will traverse full object graph which will mean the end of object stream.

I implement low level decoding methods like readInteger or #readByte which are used for specific objects materialization.
Objects manage binary decoding of instances in class side method:
	createTostInstanceWith: aTostTransporter
 
During materialization #processedObject dictionary contains all materialized objects as values and indexes inside stream as keys.
And #processedClasses dictionary contains all classes of materialized objects as values and indexes inside stream as keys.

To read full object use #materializeObject message.

Internal Representation and Key Implementation Points.

    Instance Variables
	transportStream:		<Stream>
	objectIndex:		<Integert>
	processedClasses:		<IdentityDictionary>
	processedObjects:		<IdentityDictionary>
	transport:		<TostTransport>
	traveler:		<ObjectTraveler>
	finalMaterializationActions: <IdentityDictionary<Object, BlockClosure>>
	network:		<SeamlessNetwork>
	remotePeer:		<SeamlessRemotePeer>
			   
"
Class {
	#name : #TostTransporter,
	#superclass : #Object,
	#instVars : [
		'transportStream',
		'traveler',
		'objectIndex',
		'processedObjects',
		'processedClasses',
		'finalMaterializationActions',
		'transport'
	],
	#category : #TostSerializer
}

{ #category : #'instance creation' }
TostTransporter class >> using: aTostTransport on: transportStream [
	^self new 
		transport: aTostTransport;
		transportStream: transportStream
]

{ #category : #controlling }
TostTransporter >> atNextStepProcess: anObject [
	traveler atNextStepVisit: anObject
]

{ #category : #'reading-objects' }
TostTransporter >> completeMaterializationOf: anObject [
	| action |
	finalMaterializationActions isEmptyOrNil ifTrue: [ ^self ]. "For optimization we never initialize post actions with empty array because in many cases post processing is not required"
	
	action := finalMaterializationActions removeKey: anObject ifAbsent: [^self].
	action value
]

{ #category : #initialization }
TostTransporter >> initialize [
	super initialize.
	
	processedObjects := IdentityDictionary new.
	processedClasses := IdentityDictionary new.
]

{ #category : #api }
TostTransporter >> materializeObject [
	| newObject object |	
	traveler := ObjectTraveler new.
	traveler whenLeaveNodeDo: [:node | self completeMaterializationOf: node ].	
	object := self readNextObject.
	(traveler isTraversed: object) ifTrue: [ 
		"The initial read of root object marks it as completely processed.
		So nothing else needs to be done with it"
		^object ].
	traveler startOn: object.			
				
	[ transportStream atEnd not and: [traveler moveToNextReference]] whileTrue: [ 
		newObject := self readNextObject.	
		traveler replaceCurrentReferenceWith: newObject
	 ].

	"While there are no other references under traversal route
	the traveler points to the last leaf child node which can be inside deep children tree.
	So the next step here is to leave all of them	to signal their materialization completion"
	traveler moveToNextReference. 
	"But the root object is never left the trafersal 
	and therefore we should complete the materialization of the root manually"
	self completeMaterializationOf: object. 
	^object
]

{ #category : #accessing }
TostTransporter >> objectIndex [
	^ objectIndex
]

{ #category : #accessing }
TostTransporter >> objectIndex: anObject [
	objectIndex := anObject
]

{ #category : #accessing }
TostTransporter >> processedClassAt: index [
	^processedClasses at: index
]

{ #category : #accessing }
TostTransporter >> processedObjectAt: index [
	^processedObjects at: index
]

{ #category : #testing }
TostTransporter >> processesObject: anObject asNodeAt: pathNodesIndex [

	| actualNode |
	actualNode := traveler nodeAt: pathNodesIndex ifAbsent: [ ^false ].
	^anObject == actualNode
]

{ #category : #'reading-primitive data' }
TostTransporter >> readByte [
	^transportStream next
]

{ #category : #'reading-primitive data' }
TostTransporter >> readBytes: count [

	^transportStream next: count.

]

{ #category : #'reading-primitive data' }
TostTransporter >> readBytes: count as: aByteArrayClass [
	| bytes |
	bytes := self readBytes: count.

	bytes class == aByteArrayClass ifFalse: [ 
		MirrorPrimitives setClass: aByteArrayClass to: bytes].
	
	^bytes
]

{ #category : #'reading-primitive data' }
TostTransporter >> readInteger [

	| bytesSize bytes signByte |
	bytesSize := transportStream next.
	signByte := transportStream next.
	bytes := transportStream next: bytesSize.
	^signByte = 0 ifTrue: [bytes asInteger] ifFalse: [ bytes asInteger negated ]
]

{ #category : #'reading-objects' }
TostTransporter >> readNewClassAndObject [
	
	| className class |
	className := self readString: ByteString.
	class := self class environment at: className asSymbol.
		
	processedClasses at: objectIndex put: class.
	^self readNewObjectOf: class
]

{ #category : #'reading-objects' }
TostTransporter >> readNewObjectOf: aClass [

	| newObject |
	newObject := aClass createTostInstanceWith: self.
	newObject isTostValueObject ifFalse: [ 
		processedObjects at: objectIndex put: newObject].
	^newObject
]

{ #category : #'reading-objects' }
TostTransporter >> readNextObject [
	objectIndex := transportStream position.
	^transport readObjectWith: self
]

{ #category : #'reading-objects' }
TostTransporter >> readObject [

	^transport readObjectWith: self
]

{ #category : #'reading-primitive data' }
TostTransporter >> readPositiveInteger [

	| bytesSize bytes |
	bytesSize := transportStream next.
	bytes := transportStream next: bytesSize.
	^bytes asInteger
]

{ #category : #'reading-primitive data' }
TostTransporter >> readString: stringClass [

	| bytesSize bytes |
	bytesSize := self readPositiveInteger.
	bytes := self readBytes: bytesSize.
	^stringClass fromByteArray: bytes
]

{ #category : #api }
TostTransporter >> serialize: anObject [

	traveler := ObjectTraveler new.	
	self writeNextObject: anObject.	
	(traveler isTraversed: anObject) ifTrue: [ 
		"The initial write of root object marks it as completely processed.
		So nothing else needs to be done with it"
		^self ].
	traveler startOn: anObject.
	
	traveler referencesDo: [ :each | 
		self writeNextObject: each ]
]

{ #category : #controlling }
TostTransporter >> skip: anObject [
	traveler skip: anObject
]

{ #category : #accessing }
TostTransporter >> transport [
	^ transport
]

{ #category : #accessing }
TostTransporter >> transport: anObject [
	transport := anObject
]

{ #category : #accessing }
TostTransporter >> transportStream [
	^ transportStream
]

{ #category : #accessing }
TostTransporter >> transportStream: anObject [
	transportStream := anObject
]

{ #category : #accessing }
TostTransporter >> traveler [ 
	^traveler
]

{ #category : #accessing }
TostTransporter >> traveler: anObject [
	traveler := anObject
]

{ #category : #controlling }
TostTransporter >> whenMaterializationDoneFor: anObject do: actionBlock [
	"When anObject created from stream it can require post processing action.
	I execute them when traveler left given object 
	which means that anObject graph is completally read from stream"
	finalMaterializationActions ifNil: [ finalMaterializationActions := IdentityDictionary new].
	
	finalMaterializationActions at: anObject put: actionBlock
]

{ #category : #'writing-primitive data' }
TostTransporter >> writeByte: aByte [

	transportStream nextPut: aByte
]

{ #category : #'writing-primitive data' }
TostTransporter >> writeBytes: aByteArray [
	
	transportStream nextPutAll: aByteArray 
]

{ #category : #'writing-objects' }
TostTransporter >> writeDuplicatedClass: aClass format: formatId [

	processedClasses 
		at: aClass ifPresent: [:index |
			self writeObjectIndex: index format: formatId.
			^true]
		ifAbsentPut: objectIndex.
		
	^false
]

{ #category : #'writing-objects' }
TostTransporter >> writeDuplicatedObject: anObject format: formatId [

	anObject isTostValueObject ifTrue: [ ^false ].
	
	processedObjects 
		at: anObject ifPresent: [:index |
			self writeObjectIndex: index format: formatId.
			^true]
		ifAbsentPut: objectIndex.

	^false
]

{ #category : #'writing-primitive data' }
TostTransporter >> writeInteger: anInteger [
	| bytesSize |
	bytesSize := anInteger bytesCount.
	bytesSize > 255 ifTrue: [ self error: 'Too big integer is not supported' ].
	transportStream nextPut: bytesSize.
	transportStream nextPut: (anInteger < 0 ifTrue: [ 1 ] ifFalse: [ 0 ]).
	bytesSize to: 1 by: -1 do: [ :i | transportStream nextPut: (anInteger byteAt: i) ]
]

{ #category : #'writing-objects' }
TostTransporter >> writeNextObject: anObject [
	objectIndex := transportStream position.
	self writeObject: anObject
]

{ #category : #'writing-objects' }
TostTransporter >> writeObject: anObject [

	^transport writeObject: anObject with: self
]

{ #category : #'writing-objects' }
TostTransporter >> writeObjectClass: aClass format: binaryType [
	
	transportStream nextPut: binaryType.
	aClass name isByteString
		ifFalse: [ self error: 'Only classes with bytestring names are supported' ].
		
	self writeString: aClass name
]

{ #category : #'writing-objects' }
TostTransporter >> writeObjectIndex: objectIdInteger format: binaryTypeByte [

	transportStream nextPut: binaryTypeByte.
	self writePositiveInteger: objectIdInteger 
]

{ #category : #'writing-primitive data' }
TostTransporter >> writePositiveInteger: anInteger [
	| bytesSize |
	anInteger < 0 ifTrue: [ self error: 'Given int should be positive' ].
	bytesSize := anInteger bytesCount.
	bytesSize > 255 ifTrue: [ self error: 'Too big integer is not supported' ].
	transportStream nextPut: bytesSize.
	bytesSize to: 1 by: -1 do: [ :i | transportStream nextPut: (anInteger byteAt: i) ]
]

{ #category : #'writing-objects' }
TostTransporter >> writeSmallObjectIndex: objectIdByte format: binaryTypeByte [

	transportStream nextPut: binaryTypeByte.
	transportStream nextPut: objectIdByte
]

{ #category : #'writing-primitive data' }
TostTransporter >> writeString: aString [
	
	| bytes |
	bytes := aString asByteArray.
	self writePositiveInteger: bytes size.
	transportStream nextPutAll: bytes
]

{ #category : #'writing-objects' }
TostTransporter >> writeSubstitution: substitutionObject for: anObject format: formatId [

	self writeByte: formatId.
	self writeObject: substitutionObject.
	self atNextStepProcess: substitutionObject.
	self skip: anObject
]
