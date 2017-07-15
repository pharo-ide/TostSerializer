accessing
formatIdFor: aTostFormatClass

	formats doWithIndex: [ :each :id | 
		each class = aTostFormatClass ifTrue: [ ^id ]].
	
	self error: 'Format is not defined'