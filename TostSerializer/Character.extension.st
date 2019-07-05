Extension { #name : #Character }

{ #category : #'*TostSerializer' }
Character class >> createTostInstanceWith: aTostMaterialization [

	^self value: aTostMaterialization readPositiveInteger 
]

{ #category : #'*TostSerializer' }
Character >> isTostValueObject [ 
	^true
]

{ #category : #'*TostSerializer' }
Character >> writeTostBodyWith: aTostSerialization [
	
	aTostSerialization writePositiveInteger: self asInteger
]
