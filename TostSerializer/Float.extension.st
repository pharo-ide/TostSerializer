Extension { #name : #Float }

{ #category : #'*TostSerializer' }
Float class >> createTostInstanceWith: aTostMaterialization [
	^ (self new: 2)
		at: 1 put: aTostMaterialization readPositiveInteger;
		at: 2 put: aTostMaterialization readPositiveInteger;
		yourself.

]

{ #category : #'*TostSerializer' }
Float >> writeTostBodyWith: aTostSerialization [

	aTostSerialization
		writePositiveInteger:  (self at: 1);
		writePositiveInteger:  (self at: 2)
]
