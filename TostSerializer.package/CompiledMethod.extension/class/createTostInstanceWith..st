*TostSerializer
createTostInstanceWith: aTostMaterialization

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