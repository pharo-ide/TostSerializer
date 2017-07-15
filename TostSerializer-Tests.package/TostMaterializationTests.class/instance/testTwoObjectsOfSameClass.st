tests-objects
testTwoObjectsOfSameClass

	| first second |
	self serializeAll: {Object new. Object new}.
	
	first := materializer materializeObject.
	second := materializer materializeObject.
	
	first should beInstanceOf: Object.
	second should beInstanceOf: Object.
	first should not be: second