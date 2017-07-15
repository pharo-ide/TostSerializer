reading-objects
readNextObject
	objectIndex := self dataPosition.
	^transporter readObjectWith: self