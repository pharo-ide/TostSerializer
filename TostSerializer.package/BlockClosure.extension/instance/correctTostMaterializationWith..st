*TostSerializer
correctTostMaterializationWith: materializedWordSize

	| numLiterals originalLiteralSize newLiteralSize |
	numLiterals := self method numLiterals + 1.
	newLiteralSize := numLiterals * Smalltalk wordSize.
	originalLiteralSize := numLiterals * materializedWordSize.
	"current startpc is also original materialized value.
	We should shift it according to new literal size"
	startpc := startpc - (originalLiteralSize - newLiteralSize)