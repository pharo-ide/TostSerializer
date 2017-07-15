*TostSerializer
correctTostMaterializationWith: materializedWordSize

	| numLiterals originalLiteralSize newLiteralSize |
	pc ifNil: [ ^self ].
	numLiterals := self method numLiterals + 1.
	newLiteralSize := numLiterals * Smalltalk wordSize.
	originalLiteralSize := numLiterals * materializedWordSize.
	"current pc is also original materialized value.
	We should shift it according to new literal size"
	pc := pc - (originalLiteralSize - newLiteralSize)