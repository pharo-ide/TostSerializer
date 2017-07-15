tests-objects
testCompiledMethod

	| actual area |
	transporter addFirstFormat: (TostWellKnownObjectFormat on: {Rectangle}).
	self serialize: Rectangle >> #area.
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: CompiledMethod.
	area := actual valueWithReceiver: (0@0 corner: 2@3) arguments: #().
	area should equal: 6