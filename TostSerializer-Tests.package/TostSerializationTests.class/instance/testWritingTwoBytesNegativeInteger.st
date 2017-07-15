tests-primitive data
testWritingTwoBytesNegativeInteger

	serialization writeInteger: -300.
	
	self binaryData should equal: {2. 1. 300 digitAt: 2. 300 digitAt: 1} asByteArray 