Extension { #name : #Context }

{ #category : #'*TostSerializer' }
Context >> correctTostMaterializationWith: materializedWordSize [

	| numLiterals originalLiteralSize newLiteralSize |
	pc ifNil: [ ^self ].
	numLiterals := self method numLiterals + 1.
	newLiteralSize := numLiterals * Smalltalk wordSize.
	originalLiteralSize := numLiterals * materializedWordSize.
	"current pc is also original materialized value.
	We should shift it according to new literal size"
	pc := pc - (originalLiteralSize - newLiteralSize)
]

{ #category : #'*TostSerializer' }
Context class >> createTostInstanceWith: aTostMaterialization [

	| frameSize wordSize context |
	wordSize := aTostMaterialization readByte.
	frameSize := aTostMaterialization readByte.	
	context := super basicNew: frameSize.	
	aTostMaterialization 
		whenInstanceReady: context do: [ context correctTostMaterializationWith: wordSize ].
	^context
]

{ #category : #'*TostSerializer' }
Context >> writeTostBodyWith: aTostSerialization [

	aTostSerialization writeByte: Smalltalk wordSize.
	aTostSerialization writeByte: self method frameSize
]
