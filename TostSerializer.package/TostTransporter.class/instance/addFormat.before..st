accessing
addFormat: aTostBinaryFormat before: formatClass
	| existingFormatIndex newFormats |
	existingFormatIndex := self formatIdFor: formatClass.
	
	newFormats := formats asOrderedCollection.
	newFormats add: aTostBinaryFormat beforeIndex: existingFormatIndex.
	
	self formats: newFormats asArray