*TostSerializer
createTostInstanceWith: aTostMaterialization
	| bytes |
	bytes := ByteArray createTostInstanceWith: aTostMaterialization.
	^Bitmap decompressFromByteArray: bytes