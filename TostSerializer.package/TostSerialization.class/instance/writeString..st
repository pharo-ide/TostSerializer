writing-primitive data
writeString: aString
	
	| bytes |
	bytes := aString asByteArray.
	self writePositiveInteger: bytes size.
	dataStream nextPutAll: bytes