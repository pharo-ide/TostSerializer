tests-primitive data
testReadingTwoBytesInteger

	| actual |
	self binaryData: {2. 0. 300 digitAt: 2. 300 digitAt: 1}.
	
	actual := materializer readInteger.
	
	actual should equal: 300