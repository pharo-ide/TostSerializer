tests-primitive data
testWritingByteArray

	serialization writeBytes: #[1 2 3].
	
	self binaryData should equal: #[1 2 3]