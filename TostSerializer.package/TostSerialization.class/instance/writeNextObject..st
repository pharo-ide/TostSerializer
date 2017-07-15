writing-objects
writeNextObject: anObject
	objectIndex := self dataPosition.
	self writeObject: anObject