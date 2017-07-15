tests-objects
testObjectOfWellKnownClass

	| extraFormat |
	extraFormat := TostNewObjectOfWellKnownClassFormat on: { Point. Object. Array }.
	transporter addFirstFormat: extraFormat.
	
	serialization serialize: Object new.
	
	self binaryData should equal: {extraFormat id. 2} asByteArray