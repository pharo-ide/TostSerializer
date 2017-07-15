*TostSerializer
createTostInstanceWith: aTostMaterialization

	| frameSize wordSize context |
	wordSize := aTostMaterialization readByte.
	frameSize := aTostMaterialization readByte.	
	context := super basicNew: frameSize.	
	aTostMaterialization 
		whenInstanceReady: context do: [ context correctTostMaterializationWith: wordSize ].
	^context