tests-objects
testEmptyObject

	| actual |
	self serialize: Object new.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Object