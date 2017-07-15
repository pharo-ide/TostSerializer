tests-objects
testTreeObjectsOfSameClassWhereLastTwoAreSame

	| first second object third |
	object := Object new.
	self serializeAll: {Object new. object. object}.
	
	first := materializer materializeObject.
	second := materializer materializeObject.
	third := materializer materializeObject.
	
	first should beInstanceOf: Object.
	second should beInstanceOf: Object.
	second should be: third