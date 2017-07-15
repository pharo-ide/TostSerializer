tests-objects
testEmptyObject

	| object classNameBytes classNameSizeBytes |
	object := Object new.
	serialization serialize: object.
	classNameBytes := Object name asByteArray.
	classNameSizeBytes := #[1], classNameBytes size asByteArray.
	
	self binaryData should equal: ({transporter formatIdFor: TostNewObjectOfNewClassFormat}, classNameSizeBytes, classNameBytes) asByteArray