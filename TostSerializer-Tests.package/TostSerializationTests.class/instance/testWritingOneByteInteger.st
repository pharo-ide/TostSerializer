tests-primitive data
testWritingOneByteInteger

	serialization writeInteger: 10.
	
	self binaryData should equal: #[1 0 10]