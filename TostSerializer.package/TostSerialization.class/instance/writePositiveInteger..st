writing-primitive data
writePositiveInteger: anInteger

	| bytesSize |
	anInteger < 0 ifTrue: [ self error: 'Given int should be positive' ].
	bytesSize := anInteger digitLength.
	bytesSize > 255 ifTrue: [ self error: 'Too big integer is not supported' ].
	
	dataStream nextPut: bytesSize.
	bytesSize to: 1 by: -1 do: [ :i |
		dataStream nextPut: (anInteger digitAt: i) ]