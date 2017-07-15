tests-objects
testFraction

	| actual |
	self serialize: 3/2.
	
	actual := materializer materializeObject.
	
	actual should beKindOf: Fraction.
	actual should equal: 3/2