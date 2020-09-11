Extension { #name : #Float }

{ #category : #'*TostSerializer' }
Float class >> createTostInstanceWith: aTostTransporter [
	^ (self new: 2)
		at: 1 put: aTostTransporter readPositiveInteger;
		at: 2 put: aTostTransporter readPositiveInteger;
		yourself.

]

{ #category : #'*TostSerializer' }
Float >> writeTostBodyWith: aTostTransporter [

	aTostTransporter
		writePositiveInteger:  (self at: 1);
		writePositiveInteger:  (self at: 2)
]
