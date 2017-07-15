writing-objects
writeObjectIndex: objectIdInteger format: binaryTypeByte

	dataStream nextPut: binaryTypeByte.
	self writePositiveInteger: objectIdInteger 