reading-primitive data
readBytes: count as: aByteArrayClass
	| bytes |
	bytes := self readBytes: count.

	bytes class == aByteArrayClass ifFalse: [ 
		self adoptTo: aByteArrayClass object: bytes].
	
	^bytes