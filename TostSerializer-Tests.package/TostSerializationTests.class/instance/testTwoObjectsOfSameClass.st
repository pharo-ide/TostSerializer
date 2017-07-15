tests-objects
testTwoObjectsOfSameClass

	| object |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: Object new.
	self clearData.

	serialization serialize: Object new.
	
	self binaryData should equal: {transporter formatIdFor: TostNewObjectOfDuplicatedClassFormat. 1. 4} asByteArray 