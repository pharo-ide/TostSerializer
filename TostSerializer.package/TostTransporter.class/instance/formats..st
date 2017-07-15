accessing
formats: formatsArray
	formatsArray doWithIndex: [ :each :index | each id: index ].
	self preparedFormats: formatsArray