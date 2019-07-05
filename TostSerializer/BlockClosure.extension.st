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
BlockClosure class >> createTostInstanceWith: aTostMaterialization [
	| block wordSize |
	block := super createTostInstanceWith: aTostMaterialization.
	wordSize := aTostMaterialization readByte.
	aTostMaterialization 
		whenInstanceReady: block do: [ block correctTostMaterializationWith: wordSize ].
	^block
]

{ #category : #'*TostSerializer' }
BlockClosure >> writeTostBodyWith: aTostSerialization [
	super writeTostBodyWith: aTostSerialization.
	
	aTostSerialization writeByte: Smalltalk wordSize
]
