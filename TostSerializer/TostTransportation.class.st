"
I am a root class for concrete transportation command. There are two subclasses:
	- TostSerialization
	- TostMaterialization
I define environment of objects which are used by them
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dataStream:		<Stream>
	objectIndex:		<Integert>
	processedClasses:		<IdentityDictionary>
	processedObjects:		<IdentityDictionary>
	transporter:		<TostTransporter>
	traveler:		<ObjectTraveler>
"
Class {
	#name : #TostTransportation,
	#superclass : #Object,
	#instVars : [
		'transporter',
		'traveler',
		'dataStream',
		'objectIndex',
		'processedObjects',
		'processedClasses'
	],
	#category : 'TostSerializer'
}

{ #category : #'instance creation' }
TostTransportation class >> by: aTostTransporter on: aStream [
	^self new 
		transporter: aTostTransporter;
		dataStream: aStream
]

{ #category : #'instance creation' }
TostTransportation class >> on: aStream [
	^self new 
		dataStream: aStream
]

{ #category : #controlling }
TostTransportation >> atNextStepProcess: anObject [
	traveler atNextStepVisit: anObject
]

{ #category : #accessing }
TostTransportation >> dataPosition [
	^dataStream position
]

{ #category : #accessing }
TostTransportation >> dataStream [
	^ dataStream
]

{ #category : #accessing }
TostTransportation >> dataStream: anObject [
	dataStream := anObject
]

{ #category : #initialization }
TostTransportation >> initialize [
	super initialize.
	
	processedObjects := IdentityDictionary new.
	processedClasses := IdentityDictionary new.
]

{ #category : #testing }
TostTransportation >> isProcessObject: anObject asNodeAt: pathNodesIndex [

	| actualNode |
	actualNode := traveler nodeAt: pathNodesIndex ifAbsent: [ ^false ].
	^anObject == actualNode
]

{ #category : #accessing }
TostTransportation >> objectIndex [
	^ objectIndex
]

{ #category : #accessing }
TostTransportation >> objectIndex: anObject [
	objectIndex := anObject
]

{ #category : #controlling }
TostTransportation >> skip: anObject [
	traveler skip: anObject
]

{ #category : #accessing }
TostTransportation >> transporter [
	^ transporter
]

{ #category : #accessing }
TostTransportation >> transporter: anObject [
	transporter := anObject
]

{ #category : #accessing }
TostTransportation >> traveler [ 
	^traveler
]

{ #category : #accessing }
TostTransportation >> traveler: anObject [
	traveler := anObject
]
