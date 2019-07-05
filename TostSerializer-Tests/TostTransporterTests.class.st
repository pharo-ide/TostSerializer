Class {
	#name : #TostTransporterTests,
	#superclass : #TostTransporterTestCase,
	#category : 'TostSerializer-Tests'
}

{ #category : #tests }
TostTransporterTests >> testObjectTransportationAPI [

	| object dataStream transferredObject |
	object := { 1@2. 3@4 }.
	dataStream := ByteArray new writeStream.
	
	transporter sendObject: object to: dataStream.
	transferredObject := transporter receiveObjectFrom: dataStream contents readStream.
	
	transferredObject should equal: object.
	object should equal: { 1@2. 3@4 } "To check that transportation not touch original object"
]
