Extension { #name : #CompiledCode }

{ #category : #'*TostSerializer' }
CompiledCode class >> createTostInstanceWith: aTostTransporter [

	| size bytecodes method header numLiterals wordSize literalSize newLiteralSize |
	size := aTostTransporter readPositiveInteger.
	wordSize := aTostTransporter readByte.
	header := aTostTransporter readInteger.
	numLiterals := aTostTransporter readPositiveInteger.	
	literalSize := (numLiterals + 1) * wordSize.
	bytecodes := aTostTransporter readBytes: size - literalSize.

	method := self newMethod: bytecodes size header: header.
	newLiteralSize := (numLiterals + 1) * Smalltalk wordSize.
	method
		replaceFrom: newLiteralSize + 1 "initialPC"
		to: size + (newLiteralSize - literalSize) "new method size"
		with: bytecodes
		startingAt: 1.
	
	^method
]

{ #category : #'*TostSerializer' }
CompiledCode >> writeTostBodyWith: aTostTransporter [
	| bytecodes initialPC |
	initialPC := self initialPC.
	bytecodes := ByteArray new: self size - initialPC + 1.
	bytecodes replaceFrom: 1 to: bytecodes size with: self startingAt: initialPC.
	
	aTostTransporter writePositiveInteger: self size.
	aTostTransporter writeByte: Smalltalk wordSize. "4 or 8 for 32 and 64 bits image"
	aTostTransporter writeInteger: self header.
	aTostTransporter writePositiveInteger: self numLiterals.
	aTostTransporter writeBytes: bytecodes
]
