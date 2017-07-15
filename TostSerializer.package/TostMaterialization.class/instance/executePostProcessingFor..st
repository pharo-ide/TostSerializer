post processing
executePostProcessingFor: anObject
	| action |
	postProcessingActions isEmptyOrNil ifTrue: [ ^self ]. "For optimization we never initialize post actions with empty array because in many cases post processing is not required"
	
	action := postProcessingActions removeKey: anObject ifAbsent: [^self].
	action value