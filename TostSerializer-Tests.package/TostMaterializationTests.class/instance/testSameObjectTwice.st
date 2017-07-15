tests-objects
testSameObjectTwice

	| object first second |
	object := Object new.
	self serializeAll: {object. object}.
	
	first := materializer materializeObject.
	second := materializer materializeObject.
	
	first should beInstanceOf: Object.
	first should be: second