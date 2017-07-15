*TostSerializer
writeTostBodyWith: aTostSerialization

	aTostSerialization writePositiveInteger: denominator.
	aTostSerialization writeInteger: numerator.