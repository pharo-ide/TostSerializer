tests-primitive data
testReadingOneByteInteger

	| actual |
	self binaryData: #[1 0 10].
	
	actual := materializer readInteger.
	
	actual should equal: 10