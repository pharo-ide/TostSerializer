Extension { #name : #String }

{ #category : #'*TostSerializer' }
String class >> createTostInstanceWith: aTostTransporter [
	
	^aTostTransporter readString: self
]

{ #category : #'*TostSerializer' }
String >> writeTostBodyWith: aTostTransporter [
	
	aTostTransporter writeString: self
]
