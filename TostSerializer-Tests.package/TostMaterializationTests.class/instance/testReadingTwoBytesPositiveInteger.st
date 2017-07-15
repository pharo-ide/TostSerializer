tests-primitive data
testReadingTwoBytesPositiveInteger

	| actual |
	self binaryData: {2. 300 digitAt: 2. 300 digitAt: 1}.
	
	actual := materializer readPositiveInteger.
	
	actual should equal: 300