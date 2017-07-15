tests-objects
testObjectWhichReferencesInteger

	| actual |
	self serialize: (TostTestContainer with: 10).
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should equal: 10