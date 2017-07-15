tests-objects
testWellKnownEmptyObject

	| actual object |
	object := Object new.
	transporter addFirstFormat: (TostWellKnownObjectFormat on: {2@3. object. 10@30}).
	self serialize: object.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Object