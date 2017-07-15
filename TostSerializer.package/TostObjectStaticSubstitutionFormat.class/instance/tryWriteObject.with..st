operations
tryWriteObject: anObject with: aTostSerialization
	| substitution |
	substitution := substitutions at: anObject ifAbsent: [ ^false ].
	aTostSerialization writeSubstitution: substitution for: anObject format: id.
	^true