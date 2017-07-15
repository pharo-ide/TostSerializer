I implement object serialization.

I use object traveler to enumerate all object references and write them on stream in order according to transporter formats.
I implement low level encoding methods like writeInteger: or #writeBytes: which are used for specific objects serialization.
Objects manage binary encoding in method:
	writeTostBodyWith: aSerialization
 
My processedObject dictionary contains all serialized objects as keys and indexes inside stream as values.
My processedClasses dictionary contains all classes of serialized objects as keys and indexes inside stream as values.

Public API and Key Messages

- serialize: anObject