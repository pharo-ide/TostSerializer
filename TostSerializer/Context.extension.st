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
Context class >> createTostInstanceWith: aTostTransporter [

	| frameSize wordSize context |
	wordSize := aTostTransporter readByte.
	frameSize := aTostTransporter readByte.	
	context := super basicNew: frameSize.	
	aTostTransporter 
		whenMaterializationDoneFor: context do: [ context correctTostMaterializationWith: wordSize ].
	^context
]

{ #category : #'*TostSerializer' }
Context >> writeTostBodyWith: aTostTransporter [

	aTostTransporter writeByte: Smalltalk wordSize.
	aTostTransporter writeByte: self method frameSize
]
