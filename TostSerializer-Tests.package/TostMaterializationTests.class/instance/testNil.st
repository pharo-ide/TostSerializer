tests-objects
testNil
	| actual |
	self serialize: nil.	
		
	actual := materializer materializeObject.
	
	actual should be: nil