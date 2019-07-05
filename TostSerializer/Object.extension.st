Extension { #name : #Object }

{ #category : #'*TostSerializer' }
Object >> isTostValueObject [
	^false
]

{ #category : #'*TostSerializer' }
Object >> writeTostBodyWith: aTostSerialization [
 
	self class isVariable ifTrue: [ aTostSerialization writePositiveInteger: self size]
]
