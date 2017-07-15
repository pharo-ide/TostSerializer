tests-objects
testUUIDInstance

	| actual uuid |
	uuid := UUID new.
	self serialize: uuid.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: UUID.
	actual should equal: uuid