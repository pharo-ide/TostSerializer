writing-objects
writeSmallObjectIndex: objectIdByte format: binaryTypeByte

	dataStream nextPut: binaryTypeByte.
	dataStream nextPut: objectIdByte