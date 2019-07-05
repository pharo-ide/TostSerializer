Extension { #name : #ByteArray }

{ #category : #'*TostSerializer' }
ByteArray class >> createTostInstanceWith: aTostMaterialization [
	| size |
	size := aTostMaterialization readPositiveInteger.
	^aTostMaterialization readBytes: size as: self
]

{ #category : #'*TostSerializer' }
ByteArray >> writeTostBodyWith: aTostSerialization [
	super writeTostBodyWith: aTostSerialization.
	aTostSerialization writeBytes: self
]
