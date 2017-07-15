*TostSerializer
createTostInstanceWith: aTostMaterialization

	| instance |
	instance := super createTostInstanceWith: aTostMaterialization.
	aTostMaterialization 
		whenInstanceReady: instance do: [ instance rehash ].
	^instance