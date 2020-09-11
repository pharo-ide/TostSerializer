Extension { #name : #Fraction }

{ #category : #'*TostSerializer' }
Fraction class >> createTostInstanceWith: aTostTransporter [
	
	| denominator numerator |
	denominator := aTostTransporter readPositiveInteger.
	numerator := aTostTransporter readInteger.
	
	^numerator / denominator
]

{ #category : #'*TostSerializer' }
Fraction >> writeTostBodyWith: aTostTransporter [

	aTostTransporter writePositiveInteger: denominator.
	aTostTransporter writeInteger: numerator.
]
