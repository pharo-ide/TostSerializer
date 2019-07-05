Extension { #name : #ClassDescription }

{ #category : #'*TostSerializer' }
ClassDescription >> createTostInstanceWith: aTostMaterialization [
	^self isVariable 
		ifTrue: [ self basicNew: aTostMaterialization readPositiveInteger ]
		ifFalse: [ self basicNew]
]
