tests-objects
testIntegerInstanceOf4Bytes

	| actual |
	self serialize: 300000000. "300000000 digitLength 4"
	
	actual := materializer materializeObject.
	
	actual should equal: 300000000