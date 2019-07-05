Class {
	#name : #TostTransporterTestCase,
	#superclass : #TestCase,
	#instVars : [
		'transporter'
	],
	#category : 'TostSerializer-Tests'
}

{ #category : #testing }
TostTransporterTestCase class >> isAbstract [
	^self == TostTransporterTestCase 
]

{ #category : #running }
TostTransporterTestCase >> setUp [
	super setUp.
	
	transporter := TostTransporter formats: {
		TostDuplicatedObjectFormat new.
		TostNewObjectOfDuplicatedClassFormat new.
		TostNewObjectOfNewClassFormat new
	}
]
