Extension { #name : #Bitmap }

{ #category : #'*TostSerializer' }
Bitmap class >> createTostInstanceWith: aTostMaterialization [
	| bytes |
	bytes := ByteArray createTostInstanceWith: aTostMaterialization.
	^Bitmap decompressFromByteArray: bytes
]

{ #category : #'*TostSerializer' }
Bitmap >> writeTostBodyWith: aTostSerialization [
	self compressToByteArray writeTostBodyWith: aTostSerialization
]
