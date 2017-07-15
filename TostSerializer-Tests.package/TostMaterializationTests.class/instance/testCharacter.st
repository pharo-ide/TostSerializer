tests-objects
testCharacter

	| actual |
	self serialize: $R.
	
	actual := materializer materializeObject.
	
	actual should equal: $R