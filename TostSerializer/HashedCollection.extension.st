Extension { #name : #HashedCollection }

{ #category : #'*TostSerializer' }
HashedCollection class >> createTostInstanceWith: aTostTransporter [

	| instance |
	instance := super createTostInstanceWith: aTostTransporter.
	aTostTransporter 
		whenMaterializationDoneFor: instance do: [ instance rehash ].
	^instance
]
