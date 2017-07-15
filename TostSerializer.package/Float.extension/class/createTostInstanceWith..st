*TostSerializer
createTostInstanceWith: aTostMaterialization
	^ (self new: 2)
		at: 1 put: aTostMaterialization readPositiveInteger;
		at: 2 put: aTostMaterialization readPositiveInteger;
		yourself.
