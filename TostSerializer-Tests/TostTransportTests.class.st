Class {
	#name : #TostTransportTests,
	#superclass : #TostTransportTestCase,
	#category : #'TostSerializer-Tests'
}

{ #category : #running }
TostTransportTests >> createTransportStream [
	transportStream := ByteArray new writeStream
]

{ #category : #tests }
TostTransportTests >> testObjectTransportationAPI [

	| object transferredObject |
	object := { 1@2. 3@4 }.
	
	transport sendObject: object to: transportStream.
	transferredObject := transport receiveObjectFrom: transportStream contents readStream.
	
	transferredObject should equal: object.
	object should equal: { 1@2. 3@4 } "To check that transportation not touch original object"
]
