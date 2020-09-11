Extension { #name : #ClassDescription }

{ #category : #'*TostSerializer' }
ClassDescription >> createTostInstanceWith: aTostTransporter [
	^self isVariable 
		ifTrue: [ self basicNew: aTostTransporter readPositiveInteger ]
		ifFalse: [ self basicNew]
]
