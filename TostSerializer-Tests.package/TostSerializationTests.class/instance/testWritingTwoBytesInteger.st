tests-primitive data
testWritingTwoBytesInteger

	serialization writeInteger: 300.
	
	self binaryData should equal: {2. 0. 300 digitAt: 2. 300 digitAt: 1} asByteArray