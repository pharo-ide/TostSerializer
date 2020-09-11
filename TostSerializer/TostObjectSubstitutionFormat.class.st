"
I am a root of formats hierarhy which are supposed to write another objects on a stream (substitutions) instead of originals.
All such formats will command a transporter to move in new direction to traverse a substitution object instead of original object. And the substitution in that case will be encoded by some another format defined by transport. 
According to this I implement general reading methods which are same for any my subclasses:

	readObjectWith: aTostTransporter
		| object |
		object := aTostTransporter readObject.
		aTostTransporter atNextStepProcess: object.
		^object

Reading just reads the next object from the stream but then it commands the transporter to change the traversal direction according to the serialization logic
"
Class {
	#name : #TostObjectSubstitutionFormat,
	#superclass : #TostFormat,
	#category : #TostSerializer
}

{ #category : #operations }
TostObjectSubstitutionFormat >> readObjectWith: aTostTransporter [
	| object |
	object := aTostTransporter readObject.
	aTostTransporter atNextStepProcess: object.
	^object
]
