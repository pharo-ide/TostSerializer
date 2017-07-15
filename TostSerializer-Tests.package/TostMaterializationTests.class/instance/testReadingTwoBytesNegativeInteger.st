tests-primitive data
testReadingTwoBytesNegativeInteger

	| actual |
	self binaryData: {2. 1. 300 digitAt: 2. 300 digitAt: 1}.
	
	actual := materializer readInteger.
	
	actual should equal: -300