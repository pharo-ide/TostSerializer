writing-primitive data
writeInteger: anInteger

	| bytesSize |
	bytesSize := anInteger digitLength.
	bytesSize > 255 ifTrue: [ self error: 'Too big integer is not supported' ].
	
	dataStream nextPut: bytesSize.
	dataStream nextPut: (anInteger < 0 ifTrue: [1] ifFalse: [ 0 ]).
	bytesSize to: 1 by: -1 do: [ :i |
		dataStream nextPut: (anInteger digitAt: i) ]