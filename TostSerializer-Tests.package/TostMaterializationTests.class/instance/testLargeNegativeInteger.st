tests-objects
testLargeNegativeInteger

	| actual |
	self serialize: -3575740990698772000111222.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: LargeNegativeInteger.
	actual should equal: -3575740990698772000111222