api
serialize: anObject

	traveler := ObjectTraveler on: anObject.
	
	self writeNextObject: anObject.	
		
	traveler referencesDo: [ :each | 
		self writeNextObject: each ]