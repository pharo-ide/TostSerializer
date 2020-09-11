Extension { #name : #ByteArray }

{ #category : #'*TostSerializer' }
ByteArray class >> createTostInstanceWith: aTostTransporter [
	| size |
	size := aTostTransporter readPositiveInteger.
	^aTostTransporter readBytes: size as: self
]

{ #category : #'*TostSerializer' }
ByteArray >> writeTostBodyWith: aTostTransporter [
	super writeTostBodyWith: aTostTransporter.
	aTostTransporter writeBytes: self
]
