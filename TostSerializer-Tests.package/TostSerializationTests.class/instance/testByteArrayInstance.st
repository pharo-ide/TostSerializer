tests-objects
testByteArrayInstance

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