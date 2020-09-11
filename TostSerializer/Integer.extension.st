Extension { #name : #Integer }

{ #category : #'*TostSerializer' }
Integer >> byteAt: anInteger [
	"Compatibility with Pharo7. In Pharo8/9 #digitAt: was changed to #byteAt:"
	^ self digitAt: anInteger
]

{ #category : #'*TostSerializer' }
Integer >> bytesCount [
	"Compatibility with Pharo7. In Pharo8/9 #digitLength was changed to #bytesCount"
	^ self digitLength
]

{ #category : #'*TostSerializer' }
Integer class >> createTostInstanceWith: aTostTransporter [
	^aTostTransporter readInteger 
]

{ #category : #'*TostSerializer' }
Integer >> writeTostBodyWith: aTostTransporter [
	
	aTostTransporter writeInteger: self
]
