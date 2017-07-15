*TostSerializer
createTostInstanceWith: aTostMaterialization
	| size |
	size := aTostMaterialization readPositiveInteger.
	^aTostMaterialization readBytes: size as: self