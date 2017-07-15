api
sendObject: anObject to: aWriteStream

	| serialization |
	serialization := TostSerialization by: self on: aWriteStream.
	serialization serialize: anObject