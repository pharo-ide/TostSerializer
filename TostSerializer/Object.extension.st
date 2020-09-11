Extension { #name : #Object }

{ #category : #'*TostSerializer' }
Object >> isTostValueObject [
	^false
]

{ #category : #'*TostSerializer' }
Object >> writeTostBodyWith: aTostTransporter [
 
	self class isVariable ifTrue: [ aTostTransporter writePositiveInteger: self size]
]
