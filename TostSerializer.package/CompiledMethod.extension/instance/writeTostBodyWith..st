*TostSerializer
writeTostBodyWith: aTostSerialization
	| bytecodes initialPC |
	initialPC := self initialPC.
	bytecodes := ByteArray new: self size - initialPC + 1.
	bytecodes replaceFrom: 1 to: bytecodes size with: self startingAt: initialPC.
	
	aTostSerialization writePositiveInteger: self size.
	aTostSerialization writeByte: Smalltalk wordSize. "4 or 8 for 32 and 64 bits image"
	aTostSerialization writePositiveInteger: self header.
	aTostSerialization writePositiveInteger: self numLiterals.
	aTostSerialization writeBytes: bytecodes