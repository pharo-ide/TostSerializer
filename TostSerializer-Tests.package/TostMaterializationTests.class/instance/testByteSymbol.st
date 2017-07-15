tests-objects
testByteSymbol

	| actual |
	self serialize: #'test string'.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: ByteSymbol.
	actual should equal: #'test string'