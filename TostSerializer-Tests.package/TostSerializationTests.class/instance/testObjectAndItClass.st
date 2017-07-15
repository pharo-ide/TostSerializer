tests-objects
testObjectAndItClass

	| object |
	object := Object new.
	serialization writeBytes: #[ 1 2 3 4 ].
	serialization serialize: Object new.
	self clearData.
	serialization writeObject: Object.
	
	self binaryData first should equal: (transporter formatIdFor: TostNewObjectOfNewClassFormat)