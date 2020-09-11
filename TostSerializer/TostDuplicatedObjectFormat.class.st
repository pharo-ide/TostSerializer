"
I am a format which specifies how to encode duplicated objects which was already written on a stream.
I encode them by a stream position where they was already written
"
Class {
	#name : #TostDuplicatedObjectFormat,
	#superclass : #TostStreamlineFormat,
	#category : #TostSerializer
}

{ #category : #operations }
TostDuplicatedObjectFormat >> readObjectWith: aTostTransporter [ 
	| objectIndex |
	objectIndex := aTostTransporter readPositiveInteger.
	
	^aTostTransporter processedObjectAt: objectIndex
]

{ #category : #operations }
TostDuplicatedObjectFormat >> tryWriteObject: anObject with: aTostTransporter [
	
	^aTostTransporter writeDuplicatedObject: anObject format: id
]
