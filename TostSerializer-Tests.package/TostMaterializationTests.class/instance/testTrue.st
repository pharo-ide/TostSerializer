tests-objects
testTrue
	| actual |
	self serialize: true.	
		
	actual := materializer materializeObject.
	
	actual should be: true