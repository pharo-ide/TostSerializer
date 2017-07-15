tests-objects
testByteString

	| actual |
	self serialize: 'test string'.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: ByteString.
	actual should equal: 'test string'