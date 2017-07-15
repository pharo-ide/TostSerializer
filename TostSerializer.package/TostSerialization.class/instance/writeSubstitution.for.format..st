writing-objects
writeSubstitution: substitutionObject for: anObject format: formatId

	self writeByte: formatId.
	self writeObject: substitutionObject.
	self atNextStepProcess: substitutionObject.
	self skip: anObject