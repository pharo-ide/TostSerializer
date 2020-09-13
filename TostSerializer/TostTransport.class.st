"
I define transport protocol by collection of formats which should be applied for transferred objects.
I am a kind of constructor for domain specific transporters. I should be created with formats array which define specific properties of serialization protocol.

	transporter := TostTransporter formats: {
		TostDuplicatedObjectFormat new.
		TostNewObjectOfDuplicatedClassFormat new.
		TostNewObjectOfNewClassFormat new}

High level api methods are named according to transport logic:

	transporter sendObject: anObject to: aStream
	transporter receiveObjectFrom: aStream  

Actual serialization and materialization logic is implemented by TostTransporter.
I provide two low level methods to read and write objects according to defined formats.

- writeObject: anObject with: aTransporter
- readObjectWith: aTransporter

Formats define logic how to write objects in specific cases. For example how to write completelly new object on a stream or how to write duplicated object which was already written on a stream or how to write new object which class was already written on a stream during previous object serialization. 

For writing an object on a stream I ask each format to try it. And I stop at the format which was suitable to given object and which actualy performed writing on a stream. 

	TostTransporter>>writeObject: anObject with: aTostTransporter
		| success |
		formats do: [ :each | 		 
			success := each tryWriteObject: anObject with: aTostTransporter.
			success ifTrue: [ ^true ] ].
		^false
	
When format writes the object on the stream it puts own format index as a first byte followed by the rest bytes which are appropriate for given format and object.
When I am created with formats array I initialize their indexes according to given array position . This structure should be same on sender and receiver sides which means that I should has same state on both sides of transportation.

When I read object from a stream I first read a format index and extract a format instance from my formats array. Then the found format read the object. Concrete format knows how to do it correctly according to own serialization logic.

	TostTransporter>>readObjectWith: aTostTransporter
		| objectFormatType currentFormat |
		objectFormatType := aTostTransporter readByte.	
		currentFormat := formats at: objectFormatType.
		^currentFormat readObjectWith: aTostTransporter
	
Look at hierarhy of TostFormat and comments for detailes.

Important detail:
Any configuration of my instances should always include two formats: TostNewObjectOfNewClassFormat and TostDuplicatedObjectFormat. 
First format implements actual serialization of object writing its corresponding binary data. It is impossible to serialize objects without this format. 
Second format implements correct serialization of cyclic objects graph. Without it all cyclic references will be encoded as copies of original object. 

Concrete applications can use me as is with specific combination for existing format. But also they can implement new formats and subclass me and transporter to put extra logic according to them (which could be reused by serialization and materialization to support new format). For example look SeamlessTransport, SeamlessTransporter and SeamlessSubstitutionTostFormat in project Seamless which is a main use case for TostSerializer.

Internal Representation and Key Implementation Points.

    Instance Variables
	formats:		<Array of<TostFormat>>
"
Class {
	#name : #TostTransport,
	#superclass : #Object,
	#instVars : [
		'formats'
	],
	#category : #TostSerializer
}

{ #category : #'instance creation' }
TostTransport class >> formats: formatsArray [
	^self new 
		formats: formatsArray 
]

{ #category : #accessing }
TostTransport >> addFirstFormat: aTostBinaryFormat [
	self formats: { aTostBinaryFormat }, formats
]

{ #category : #accessing }
TostTransport >> addFormat: aTostBinaryFormat before: formatClass [
	| existingFormatIndex newFormats |
	existingFormatIndex := self formatIdFor: formatClass.
	
	newFormats := formats asOrderedCollection.
	newFormats add: aTostBinaryFormat beforeIndex: existingFormatIndex.
	
	self formats: newFormats asArray
]

{ #category : #accessing }
TostTransport >> formatIdFor: aTostFormatClass [

	formats doWithIndex: [ :each :id | 
		each class = aTostFormatClass ifTrue: [ ^id ]].
	
	self error: 'Format is not defined'
]

{ #category : #accessing }
TostTransport >> formats [
	^ formats
]

{ #category : #accessing }
TostTransport >> formats: formatsArray [
	formatsArray doWithIndex: [ :each :index | each id: index ].
	self preparedFormats: formatsArray
]

{ #category : #api }
TostTransport >> newTransporterOn: transportStream [

	^TostTransporter using: self on: transportStream
]

{ #category : #accessing }
TostTransport >> preparedFormats: formatsArray [
	formats := formatsArray
]

{ #category : #operations }
TostTransport >> readObjectWith: aTostTransporter [

	| objectFormatType currentFormat |
	
	objectFormatType := aTostTransporter readByte.	
	currentFormat := formats at: objectFormatType.
	
	^currentFormat readObjectWith: aTostTransporter
]

{ #category : #api }
TostTransport >> receiveObjectFrom: transportStream [

	| transporter |
	transporter := self newTransporterOn: transportStream.
	^transporter materializeObject
]

{ #category : #api }
TostTransport >> sendObject: anObject to: transportStream [

	| transporter |
	transporter := self newTransporterOn: transportStream.
	transporter serializeObject: anObject
]

{ #category : #operations }
TostTransport >> writeObject: anObject with: aTostTransporter [
	| success |
	formats do: [ :each | 		 
		success := each tryWriteObject: anObject with: aTostTransporter.
		success ifTrue: [ ^true ] ].
	
	^false
]
