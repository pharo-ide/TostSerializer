tests-objects
testObjectOfWellKnownClass

	| actual |
	transporter addFirstFormat: (TostNewObjectOfWellKnownClassFormat on: { Object }).
	self serialize: Object new.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Object