"
I am a root of tost formats hierarhy. My subclasses should implement specific cases for objects serialization/materialization process.

For example they could define how to write completelly new object on a stream or how to write a duplicated object which was already written on the stream or how to write new object which class was already written on a stream during previous object serialization. 

Subclasses should implement two methods:

- tryWriteObject: anObject with: aTostTransporter
- readObjectWith: aTostTransporter

Write method should decide if given object is suitable for the receiver format. And only if it really writes an object on a steams it should return true. Otherwise false. 
Read method should just read an object assuming that the object on a stream was really written using the receiver format.

My id variable is byte which is used as preamble for any object encoding. It assigned to me by transporter during initialization time.

Internal Representation and Key Implementation Points.

    Instance Variables
	id:		<SmallInteger>	""byte""
"
Class {
	#name : #TostFormat,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #TostSerializer
}

{ #category : #accessing }
TostFormat >> id [
	^id
]

{ #category : #accessing }
TostFormat >> id: aByte [
	id := aByte
]

{ #category : #operations }
TostFormat >> readObjectWith: aTostTransporter [
	self subclassResponsibility 
]

{ #category : #operations }
TostFormat >> tryWriteObject: anObject with: aTostTransporter [
	self subclassResponsibility 
]
