Extension { #name : #HashedCollection }

{ #category : #'*TostSerializer' }
HashedCollection class >> createTostInstanceWith: aTostMaterialization [

	| instance |
	instance := super createTostInstanceWith: aTostMaterialization.
	aTostMaterialization 
		whenInstanceReady: instance do: [ instance rehash ].
	^instance
]
