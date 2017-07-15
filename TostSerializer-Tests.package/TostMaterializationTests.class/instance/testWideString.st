tests-objects
testWideString

	| actual |
	self serialize: '1234' asWideString .
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: WideString.
	actual should equal: '1234' asWideString