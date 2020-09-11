Extension { #name : #Bitmap }

{ #category : #'*TostSerializer' }
Bitmap class >> createTostInstanceWith: aTostTransporter [
	| bytes |
	bytes := ByteArray createTostInstanceWith: aTostTransporter.
	^Bitmap decompressFromByteArray: bytes
]

{ #category : #'*TostSerializer' }
Bitmap >> writeTostBodyWith: aTostTransporter [
	self compressToByteArray writeTostBodyWith: aTostTransporter
]
