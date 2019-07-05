Extension { #name : #Integer }

{ #category : #'*TostSerializer' }
Integer class >> createTostInstanceWith: aTostMaterialization [
	^aTostMaterialization readInteger 
]

{ #category : #'*TostSerializer' }
Integer >> writeTostBodyWith: aTostSerialization [
	
	aTostSerialization writeInteger: self
]
