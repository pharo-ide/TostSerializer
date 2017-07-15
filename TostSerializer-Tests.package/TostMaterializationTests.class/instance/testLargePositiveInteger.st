tests-objects
testLargePositiveInteger

	| actual |
	self serialize: 3575740990698772000111222.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: LargePositiveInteger.
	actual should equal: 3575740990698772000111222