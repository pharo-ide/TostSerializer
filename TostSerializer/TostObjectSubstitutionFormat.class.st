"
I am a root of formats hierarhy which are supposed to write another objects on stream (substitution) instead of original.
All such formats will command serialization process to move in new direction to traveres substitution object instead of original. And substitution in that case will be encoded by some another format defined by transporter. 
According to this I implement general reading methods which are same for any my subclasses:

	readObjectWith: aTostMaterialization
		| object |
		object := aTostMaterialization readObject.
		aTostMaterialization atNextStepProcess: object.
		^object

Reading  just read next object from stream but then it commands materialization process to change traversal direction according to serialization logic
"
Class {
	#name : #TostObjectSubstitutionFormat,
	#superclass : #TostFormat,
	#category : 'TostSerializer'
}

{ #category : #operations }
TostObjectSubstitutionFormat >> readObjectWith: aTostMaterialization [
	| object |
	object := aTostMaterialization readObject.
	aTostMaterialization atNextStepProcess: object.
	^object
]
