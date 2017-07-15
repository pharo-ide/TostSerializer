tests-objects
testIntegerInstance

	| actual |
	self serialize: 300.
	
	actual := materializer materializeObject.
	
	actual should equal: 300