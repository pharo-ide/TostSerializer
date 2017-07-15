tests-objects
testNegativeFloatInstance

	| actual |
	self serialize: -1.5.
	
	actual := materializer materializeObject.
	
	actual should beKindOf: Float.
	actual should equal: -1.5