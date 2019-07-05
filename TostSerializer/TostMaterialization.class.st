"
I implement object materialization.

I materialize objects step by step. First I read root and start iterate references by object traveler. For each reference (which are nil from begining) I read next object from stream and assign it to given reference.  Object travel iterates in breadth first direction. So at some point it will go deeply to next read object which will be materialized in same way as root. This loop will continue until traveler will traverse full object graph which should means end of object stream.

I implement low level decoding methods like readInteger or #readByte which are used for specific objects materialization.
Objects manage binary decoding of instances in class side method:
	createTostInstanceWith: aMaterialization
 
My processedObject dictionary contains all materialized objects as values and indexes inside stream as keys.
My processedClasses dictionary contains all classes of materialized objects as values and indexes inside stream as keys.

Public API and Key Messages

- materializeObject
"
Class {
	#name : #TostMaterialization,
	#superclass : #TostTransportation,
	#instVars : [
		'postProcessingActions'
	],
	#category : 'TostSerializer'
}

{ #category : #'reading-primitive data' }
TostMaterialization >> adoptTo: aClass object: anObject [

	<primitive: 160>
	self primitiveFailed
]

{ #category : #'post processing' }
TostMaterialization >> executePostProcessingFor: anObject [
	| action |
	postProcessingActions isEmptyOrNil ifTrue: [ ^self ]. "For optimization we never initialize post actions with empty array because in many cases post processing is not required"
	
	action := postProcessingActions removeKey: anObject ifAbsent: [^self].
	action value
]

{ #category : #api }
TostMaterialization >> materializeObject [
	| newObject object |	
	object := self readNextObject.
	traveler := ObjectTraveler on: object.
	traveler whenLeaveNodeDo: [:node | self executePostProcessingFor: node ].

	[ dataStream atEnd not and: [traveler moveToNextReference]] whileTrue: [ 
		newObject := self readNextObject.	
		traveler replaceCurrentReferenceWith: newObject
	 ].

	traveler moveToNextReference. "it should leave all deep children nodes and signal post processing"
	self executePostProcessingFor: object. "root traversed object is never left"
	^object
]

{ #category : #accessing }
TostMaterialization >> processedClassAt: index [
	^processedClasses at: index
]

{ #category : #accessing }
TostMaterialization >> processedObjectAt: index [
	^processedObjects at: index
]

{ #category : #'reading-primitive data' }
TostMaterialization >> readByte [
	^dataStream next
]

{ #category : #'reading-primitive data' }
TostMaterialization >> readBytes: count [

	^dataStream next: count.

]

{ #category : #'reading-primitive data' }
TostMaterialization >> readBytes: count as: aByteArrayClass [
	| bytes |
	bytes := self readBytes: count.

	bytes class == aByteArrayClass ifFalse: [ 
		self adoptTo: aByteArrayClass object: bytes].
	
	^bytes
]

{ #category : #'reading-primitive data' }
TostMaterialization >> readInteger [

	| bytesSize bytes signByte |
	bytesSize := dataStream next.
	signByte := dataStream next.
	bytes := dataStream next: bytesSize.
	^signByte = 0 ifTrue: [bytes asInteger] ifFalse: [ bytes asInteger negated ]
]

{ #category : #'reading-objects' }
TostMaterialization >> readNewClassAndObject [
	
	| className class |
	className := self readString: ByteString.
	class := self class environment at: className asSymbol.
		
	processedClasses at: objectIndex put: class.
	^self readNewObjectOf: class
]

{ #category : #'reading-objects' }
TostMaterialization >> readNewObjectOf: aClass [

	| newObject |
	newObject := aClass createTostInstanceWith: self.
	newObject isTostValueObject ifFalse: [ 
		processedObjects at: objectIndex put: newObject].
	^newObject
]

{ #category : #'reading-objects' }
TostMaterialization >> readNextObject [
	objectIndex := self dataPosition.
	^transporter readObjectWith: self
]

{ #category : #'reading-objects' }
TostMaterialization >> readObject [

	^transporter readObjectWith: self
]

{ #category : #'reading-primitive data' }
TostMaterialization >> readPositiveInteger [

	| bytesSize bytes |
	bytesSize := dataStream next.
	bytes := dataStream next: bytesSize.
	^bytes asInteger
]

{ #category : #'reading-primitive data' }
TostMaterialization >> readString: stringClass [

	| bytesSize bytes |
	bytesSize := self readPositiveInteger.
	bytes := self readBytes: bytesSize.
	^stringClass fromByteArray: bytes
]

{ #category : #'post processing' }
TostMaterialization >> whenInstanceReady: anObject do: actionBlock [
	"When anObject created from stream it can require post processing action.
	I execute them when traveler left given object 
	which means that anObject graph is completally read from stream"
	postProcessingActions ifNil: [ postProcessingActions := IdentityDictionary new].
	
	postProcessingActions at: anObject put: actionBlock
]
