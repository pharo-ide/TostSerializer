*TostSerializer
createTostInstanceWith: aTostMaterialization
	| block wordSize |
	block := super createTostInstanceWith: aTostMaterialization.
	wordSize := aTostMaterialization readByte.
	aTostMaterialization 
		whenInstanceReady: block do: [ block correctTostMaterializationWith: wordSize ].
	^block