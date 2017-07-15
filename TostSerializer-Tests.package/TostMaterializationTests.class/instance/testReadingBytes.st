tests-primitive data
testReadingBytes

	| actual |
	self binaryData: #[1 2 3 4].
	
	actual := materializer readBytes: 2.
	
	actual should equal: #[1 2]