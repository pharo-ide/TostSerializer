helpers
serializeAll: objects
	
	| serializer dataStream |
	dataStream := ByteArray new writeStream.
	serializer := TostSerialization by: transporter on: dataStream.
	
	objects do: [:each | serializer serialize: each].
	
	self binaryData: dataStream contents