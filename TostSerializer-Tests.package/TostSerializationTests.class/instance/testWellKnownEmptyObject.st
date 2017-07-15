tests-objects
testWellKnownEmptyObject

	| extraFormat object |
	object := Object new.
	extraFormat := TostWellKnownObjectFormat on: {2@3. object. 10@30 }.
	transporter addFirstFormat: extraFormat.
	
	serialization serialize: object.
	
	self binaryData should equal: {extraFormat id. 2} asByteArray