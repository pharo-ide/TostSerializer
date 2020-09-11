Class {
	#name : #TostTransportTestCase,
	#superclass : #TestCase,
	#instVars : [
		'transport',
		'transporter',
		'transportStream'
	],
	#category : #'TostSerializer-Tests'
}

{ #category : #testing }
TostTransportTestCase class >> isAbstract [
	^self == TostTransportTestCase 
]

{ #category : #running }
TostTransportTestCase >> createTransportStream [
	self subclassResponsibility 
]

{ #category : #running }
TostTransportTestCase >> setUp [
	super setUp.
	
	transport := TostTransport formats: {
		TostDuplicatedObjectFormat new.
		TostNewObjectOfDuplicatedClassFormat new.
		TostNewObjectOfNewClassFormat new
	}.
	
	self createTransportStream.
	transporter := TostTransporter using: transport on: transportStream
]
