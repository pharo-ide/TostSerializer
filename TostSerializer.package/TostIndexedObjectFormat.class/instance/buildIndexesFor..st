accessing
buildIndexesFor: anArray
	anArray size > 255 ifTrue: [ self error: 'Indexed object format supports up to 255 objects' ].
	
	objects := anArray.
	indexes := IdentityDictionary new: objects size.
	objects withIndexDo: [ :each :i | indexes at: each put: i ]