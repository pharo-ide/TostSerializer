"
I am format which specifies how to encode objects of classes which was already written on stream during other instances serialization.
Originally class of object is encoded by full name string. But if new instance of object is going to be written I will use original stream position to encode class instead of name
"
Class {
	#name : #TostNewObjectOfDuplicatedClassFormat,
	#superclass : #TostStreamlineFormat,
	#category : 'TostSerializer'
}

{ #category : #operations }
TostNewObjectOfDuplicatedClassFormat >> readObjectWith: aTostMaterialization [ 
	| classIndex class |
	classIndex := aTostMaterialization readPositiveInteger.
	
	class := aTostMaterialization processedClassAt: classIndex.	
	^aTostMaterialization readNewObjectOf: class
]

{ #category : #operations }
TostNewObjectOfDuplicatedClassFormat >> tryWriteObject: anObject with: aTostSerialization [

	| written |
	written := aTostSerialization writeDuplicatedClass: anObject class format: id.
	
	written ifTrue: [ anObject writeTostBodyWith: aTostSerialization].
	
	^written
]
