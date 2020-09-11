Extension { #name : #Character }

{ #category : #'*TostSerializer' }
Character class >> createTostInstanceWith: aTostTransporter [

	^self value: aTostTransporter readPositiveInteger 
]

{ #category : #'*TostSerializer' }
Character >> isTostValueObject [ 
	^true
]

{ #category : #'*TostSerializer' }
Character >> writeTostBodyWith: aTostTransporter [
	
	aTostTransporter writePositiveInteger: self asInteger
]
