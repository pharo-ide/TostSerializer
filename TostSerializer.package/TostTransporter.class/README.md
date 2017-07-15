I define serialization protocol by collection of formats which should be applied for transferred objects.
I am kind of constructor for domain specific transporters. I should be created with formats array which define specific properties of serialization protocol.

	transporter := TostTransporter formats: {
		TostDuplicatedObjectFormat new.
		TostNewObjectOfDuplicatedClassFormat new.
		TostNewObjectOfNewClassFormat new}

High level api methods are named according to transport logic:

	transporter sendObject: anObject to: aStream
	transporter receiveObjectFrom: aStream  

Actual serialization and materialization are implemented by first class objects as command like pattern:

- TostSerialization implements serialization of objects on stream
- TostMaterialization implements materialization objects from stream

I provide two low level methods for them to read and write objects according to defined formats.

- writeObject: anObject with: aSerialization
- readObjectWith: aMaterialization

Formats define logic how to write objects in specific cases. For example how to write completelly new object on stream or how to write duplicated object which was already written on stream or how to write new object which class was already written on stream during previous object serialization. 

For writing object on stream I ask each format to try it. And I stop at format which suitable to given object and which actualy performed writing on stream. 

	TostTransporter>>writeObject: anObject with: aTostSerialization
		| success |
		formats do: [ :each | 		 
			success := each tryWriteObject: anObject with: aTostSerialization.
			success ifTrue: [ ^true ] ].
		^false
	
When format writes object on stream it puts own format index as first byte and then the rest bytes which are appropriate for given format and object.
When I am created with formats array I initialize their indexes according to given array position . This structure should be same on sender and receiver sides which means that I should has same state on both sides of transportation.

When I read object from stream I first read format index and extract format instance from my formats array. Then I just ask found format to read object. And concrete format knows how to do it correctly according to own serialization logic.

	TostTransporter>>readObjectWith: aTostMaterialization
		| objectFormatType currentFormat |
		objectFormatType := aTostMaterialization readByte.	
		currentFormat := formats at: objectFormatType.
		^currentFormat readObjectWith: aTostMaterialization
	
Look at hierarhy of TostFormat and comments for detailes.

Important detail:
Any configuration of my instances should always include two formats: TostNewObjectOfNewClassFormat and TostDuplicatedObjectFormat. 
First implements real objects serialization. It is impossible to serialize objects without this guy. 
And last implements correct serialization of cyclic objects graph. Without it cyclic references can't be correctly materialized.

Concrete applications can use me as is with specific combination for existing format. But also they can implement new formats and subclass me to put extra logic according to them (which could be reused by serialization and materialization to support new format). For example look SeamlessObjectTransporter and SeamlessSubstitutionTostFormat in project Seamless which is main use case for TostSerializer.

Internal Representation and Key Implementation Points.

    Instance Variables
	formats:		<Array of<TostFormat>>