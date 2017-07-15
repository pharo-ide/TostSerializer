tests-objects
testWellKnownCompositeObject

	| extraFormat object container |
	object := TostTestContainer with: 300.
	container := TostTestContainer with: object.
	transporter addFirstFormat: (TostNewObjectOfWellKnownClassFormat on: {TostTestContainer}).
	extraFormat := TostWellKnownObjectFormat on: {2@3. object. 10@30 }.
	transporter addFirstFormat: extraFormat.
	serialization serialize: container.
	
	self binaryData should equal: {2. 1. extraFormat id. 2} asByteArray