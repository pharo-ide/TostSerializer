testing
isProcessObject: anObject asNodeAt: pathNodesIndex

	| actualNode |
	actualNode := traveler nodeAt: pathNodesIndex ifAbsent: [ ^false ].
	^anObject == actualNode