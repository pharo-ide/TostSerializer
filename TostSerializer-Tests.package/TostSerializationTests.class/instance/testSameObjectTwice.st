tests-objects
testSameObjectTwice

	| object |
	object := Object new.
	serialization writeBytes: #[1 2 3 4]. "index of following object should be equal stream position (4)"
	serialization serialize: object.
	self clearData.
	serialization serialize: object.
	
	self binaryData should equal: ({transporter formatIdFor: TostDuplicatedObjectFormat}, #[1 4]) asByteArray