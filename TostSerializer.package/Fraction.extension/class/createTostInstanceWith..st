*TostSerializer
createTostInstanceWith: aTostMaterialization
	
	| denominator numerator |
	denominator := aTostMaterialization readPositiveInteger.
	numerator := aTostMaterialization readInteger.
	
	^numerator / denominator