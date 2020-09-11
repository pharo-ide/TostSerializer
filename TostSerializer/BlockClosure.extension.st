Extension { #name : #BlockClosure }

{ #category : #'*TostSerializer' }
BlockClosure >> correctTostMaterializationWith: materializedWordSize [

	| numLiterals originalLiteralSize newLiteralSize |
	numLiterals := self method numLiterals + 1.
	newLiteralSize := numLiterals * Smalltalk wordSize.
	originalLiteralSize := numLiterals * materializedWordSize.
	"current startpc is also original materialized value.
	We should shift it according to new literal size"
	startpc := startpc - (originalLiteralSize - newLiteralSize)
]

{ #category : #'*TostSerializer' }
BlockClosure class >> createTostInstanceWith: aTostTransporter [
	| block wordSize |
	block := super createTostInstanceWith: aTostTransporter.
	wordSize := aTostTransporter readByte.
	aTostTransporter 
		whenMaterializationDoneFor: block do: [ block correctTostMaterializationWith: wordSize ].
	^block
]

{ #category : #'*TostSerializer' }
BlockClosure >> writeTostBodyWith: aTostTransporter [
	super writeTostBodyWith: aTostTransporter.
	
	aTostTransporter writeByte: Smalltalk wordSize
]
