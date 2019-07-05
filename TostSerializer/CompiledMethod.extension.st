Extension { #name : #CompiledMethod }

{ #category : #'*TostSerializer' }
CompiledMethod class >> createTostInstanceWith: aTostMaterialization [

	| size bytecodes method header numLiterals wordSize literalSize newLiteralSize |
	size := aTostMaterialization readPositiveInteger.
	wordSize := aTostMaterialization readByte.
	header := aTostMaterialization readPositiveInteger.
	numLiterals := aTostMaterialization readPositiveInteger.	
	literalSize := (numLiterals + 1) * wordSize.
	bytecodes := aTostMaterialization readBytes: size - literalSize.

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
CompiledMethod >> writeTostBodyWith: aTostSerialization [
	| bytecodes initialPC |
	initialPC := self initialPC.
	bytecodes := ByteArray new: self size - initialPC + 1.
	bytecodes replaceFrom: 1 to: bytecodes size with: self startingAt: initialPC.
	
	aTostSerialization writePositiveInteger: self size.
	aTostSerialization writeByte: Smalltalk wordSize. "4 or 8 for 32 and 64 bits image"
	aTostSerialization writePositiveInteger: self header.
	aTostSerialization writePositiveInteger: self numLiterals.
	aTostSerialization writeBytes: bytecodes
]
