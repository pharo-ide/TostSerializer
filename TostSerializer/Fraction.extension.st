Extension { #name : #Fraction }

{ #category : #'*TostSerializer' }
Fraction class >> createTostInstanceWith: aTostMaterialization [
	
	| denominator numerator |
	denominator := aTostMaterialization readPositiveInteger.
	numerator := aTostMaterialization readInteger.
	
	^numerator / denominator
]

{ #category : #'*TostSerializer' }
Fraction >> writeTostBodyWith: aTostSerialization [

	aTostSerialization writePositiveInteger: denominator.
	aTostSerialization writeInteger: numerator.
]
