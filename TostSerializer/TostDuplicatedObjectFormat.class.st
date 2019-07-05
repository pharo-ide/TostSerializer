"
I am format which specifies how to encode duplicated objects which was already written on stream.
I encode them by stream position where they was already written
"
Class {
	#name : #TostDuplicatedObjectFormat,
	#superclass : #TostStreamlineFormat,
	#category : 'TostSerializer'
}

{ #category : #operations }
TostDuplicatedObjectFormat >> readObjectWith: aTostMaterialization [ 
	| objectIndex |
	objectIndex := aTostMaterialization readPositiveInteger.
	
	^aTostMaterialization processedObjectAt: objectIndex
]

{ #category : #operations }
TostDuplicatedObjectFormat >> tryWriteObject: anObject with: aTostSerialization [
	
	^aTostSerialization writeDuplicatedObject: anObject format: id
]
