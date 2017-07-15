reading-primitive data
readString: stringClass

	| bytesSize bytes |
	bytesSize := self readPositiveInteger.
	bytes := self readBytes: bytesSize.
	^stringClass fromByteArray: bytes