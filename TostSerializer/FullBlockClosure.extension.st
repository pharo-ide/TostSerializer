Extension { #name : #FullBlockClosure }

{ #category : #'*TostSerializer' }
FullBlockClosure >> correctTostMaterializationWith: materializedWordSize [
	"FullBlockClosure has no difference in binary presentation in 32 and 64 bit images.
	Therefore nothing to do here"
]

{ #category : #'*TostSerializer' }
FullBlockClosure class >> createTostInstanceWith: aTostTransporter [
	"FullBlockClosure has no difference in binary presentation in 32 and 64 bit images.
	Therefore the instantiation method here is simplified to Object version"
	
	^self basicNew: aTostTransporter readPositiveInteger
]

{ #category : #'*TostSerializer' }
FullBlockClosure >> writeTostBodyWith: aTostTransporter [
 	"FullBlockClosure has no difference in binary presentation in 32 and 64 bit images.
	Therefore the serialization method here is simplified to Object version"

	aTostTransporter writePositiveInteger: self size
]
