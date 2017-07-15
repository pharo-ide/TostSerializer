tests-objects
testThreeObjectsOfSameClassWhereLastTwoAreSame

	| object objectIndex |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: Object new.
	objectIndex := serialization dataPosition.
	serialization serialize: object.
	self clearData.
	serialization serialize: object.
	
	self binaryData should equal: {transporter formatIdFor: TostDuplicatedObjectFormat. 1. objectIndex} asByteArray 