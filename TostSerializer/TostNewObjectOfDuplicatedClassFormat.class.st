"
I am a format which specifies how to encode objects of classes which was already written on a stream during other instances serialization.
Initialy the class of object is encoded by full name string. But if new instance of object is going to be written I will use original stream position to encode its class instead of a name.
"
Class {
	#name : #TostNewObjectOfDuplicatedClassFormat,
	#superclass : #TostStreamlineFormat,
	#category : #TostSerializer
}

{ #category : #operations }
TostNewObjectOfDuplicatedClassFormat >> readObjectWith: aTostTransporter [ 
	| classIndex class |
	classIndex := aTostTransporter readPositiveInteger.
	
	class := aTostTransporter processedClassAt: classIndex.	
	^aTostTransporter readNewObjectOf: class
]

{ #category : #operations }
TostNewObjectOfDuplicatedClassFormat >> tryWriteObject: anObject with: aTostTransporter [

	| written |
	written := aTostTransporter writeDuplicatedClass: anObject class format: id.
	
	written ifTrue: [ anObject writeTostBodyWith: aTostTransporter].
	
	^written
]
