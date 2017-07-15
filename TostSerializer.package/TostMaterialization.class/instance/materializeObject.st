api
materializeObject
	| newObject object |	
	object := self readNextObject.
	traveler := ObjectTraveler on: object.
	traveler whenLeaveNodeDo: [:node | self executePostProcessingFor: node ].

	[ dataStream atEnd not and: [traveler moveToNextReference]] whileTrue: [ 
		newObject := self readNextObject.	
		traveler replaceCurrentReferenceWith: newObject
	 ].

	traveler moveToNextReference. "it should leave all deep children nodes and signal post processing"
	self executePostProcessingFor: object. "root traversed object is never left"
	^object