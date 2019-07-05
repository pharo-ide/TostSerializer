Extension { #name : #Symbol }

{ #category : #'*TostSerializer' }
Symbol class >> createTostInstanceWith: aTostMaterialization [

	| string |
	string := super createTostInstanceWith: aTostMaterialization.
	^string asSymbol
]
