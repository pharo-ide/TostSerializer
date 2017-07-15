tests-objects
testObjectWhichReferencesAnotherObjectWhichReferencesInteger

	| actual |
	self serialize: (TostTestContainer with: (TostTestContainer with: 10)).
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: TostTestContainer.
	actual content should beInstanceOf: TostTestContainer.
	actual content content should equal: 10