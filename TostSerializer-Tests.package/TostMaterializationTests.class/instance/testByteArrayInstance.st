tests-objects
testByteArrayInstance

	| actual |
	self serialize: #[1 2 5 10].
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: ByteArray.
	actual should equal: #[1 2 5 10]