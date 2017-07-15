tests-objects
testFalse
	| actual |
	self serialize: false.	
		
	actual := materializer materializeObject.
	
	actual should be: false