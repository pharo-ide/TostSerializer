reading-primitive data
readInteger

	| bytesSize bytes signByte |
	bytesSize := dataStream next.
	signByte := dataStream next.
	bytes := dataStream next: bytesSize.
	^signByte = 0 ifTrue: [bytes asInteger] ifFalse: [ bytes asInteger negated ]