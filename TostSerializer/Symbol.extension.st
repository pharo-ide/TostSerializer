Extension { #name : #Symbol }

{ #category : #'*TostSerializer' }
Symbol class >> createTostInstanceWith: aTostTransporter [

	| string |
	string := super createTostInstanceWith: aTostTransporter.
	^string asSymbol
]
