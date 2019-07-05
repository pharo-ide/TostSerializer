"
I am substitution format which defines substitution objects dynamically by blocks:

- conditionBlock defines what objects should be substituted
- substitutionBlock defines substitutions for given objects
 
Internal Representation and Key Implementation Points.

    Instance Variables
	conditionBlock:		<BlockClosure>
	substitutionBlock:		<BlockClosure>
"
Class {
	#name : #TostObjectDynamicSubstitutionFormat,
	#superclass : #TostObjectSubstitutionFormat,
	#instVars : [
		'substitutionBlock',
		'conditionBlock'
	],
	#category : 'TostSerializer'
}

{ #category : #'instance creation' }
TostObjectDynamicSubstitutionFormat class >> for: conditionBlock by: substitutionBlock [
	^self new 
		conditionBlock: conditionBlock;
		substitutionBlock: substitutionBlock 
]

{ #category : #accessing }
TostObjectDynamicSubstitutionFormat >> conditionBlock [
	^ conditionBlock
]

{ #category : #accessing }
TostObjectDynamicSubstitutionFormat >> conditionBlock: anObject [
	conditionBlock := anObject
]

{ #category : #accessing }
TostObjectDynamicSubstitutionFormat >> substitutionBlock [
	^ substitutionBlock
]

{ #category : #accessing }
TostObjectDynamicSubstitutionFormat >> substitutionBlock: anObject [
	substitutionBlock := anObject
]

{ #category : #operations }
TostObjectDynamicSubstitutionFormat >> tryWriteObject: anObject with: aTostSerialization [
	| substitution |
	(conditionBlock value: anObject) ifFalse: [ ^false ].
	 
	substitution := substitutionBlock value: anObject.
	aTostSerialization writeSubstitution: substitution for: anObject format: id.
	^true
]
