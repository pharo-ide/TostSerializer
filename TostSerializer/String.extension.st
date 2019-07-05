Extension { #name : #String }

{ #category : #'*TostSerializer' }
String class >> createTostInstanceWith: aTostMaterialization [
	
	^aTostMaterialization readString: self
]

{ #category : #'*TostSerializer' }
String >> writeTostBodyWith: aTostSerializer [
	
	aTostSerializer writeString: self
]
