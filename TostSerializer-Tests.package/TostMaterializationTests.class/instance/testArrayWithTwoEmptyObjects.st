tests-objects
testArrayWithTwoEmptyObjects

	| actual |
	self serialize: {Object new. Object new}.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Array.
	actual should haveSize: 2.
	actual first should beInstanceOf: Object.
	actual last should beInstanceOf: Object.