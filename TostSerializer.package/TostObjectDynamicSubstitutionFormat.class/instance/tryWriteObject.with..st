operations
tryWriteObject: anObject with: aTostSerialization
	| substitution |
	(conditionBlock value: anObject) ifFalse: [ ^false ].
	 
	substitution := substitutionBlock value: anObject.
	aTostSerialization writeSubstitution: substitution for: anObject format: id.
	^true