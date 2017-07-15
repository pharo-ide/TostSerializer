*TostSerializer
createTostInstanceWith: aTostMaterialization

	| string |
	string := super createTostInstanceWith: aTostMaterialization.
	^string asSymbol