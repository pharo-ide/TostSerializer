tests-primitive data
testWritingTwoBytesPositiveInteger

	serialization writePositiveInteger: 300.
	
	self binaryData should equal: {2. 300 digitAt: 2. 300 digitAt: 1} asByteArray 