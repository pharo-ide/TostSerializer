reading-primitive data
readPositiveInteger

	| bytesSize bytes |
	bytesSize := dataStream next.
	bytes := dataStream next: bytesSize.
	^bytes asInteger