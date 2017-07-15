reading-objects
readNewClassAndObject
	
	| className class |
	className := self readString: ByteString.
	class := self class environment at: className asSymbol.
		
	processedClasses at: objectIndex put: class.
	^self readNewObjectOf: class