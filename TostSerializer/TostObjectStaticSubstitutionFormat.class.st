"
I am substitution format which defines substitution objects by static maps.

My substitutions keys are set of objects which should be substituted.
And my substitutions values are substitutions.

Internal Representation and Key Implementation Points.

    Instance Variables
	substitutions:		<IdentityDictionary>
"
Class {
	#name : #TostObjectStaticSubstitutionFormat,
	#superclass : #TostObjectSubstitutionFormat,
	#instVars : [
		'substitutions'
	],
	#category : 'TostSerializer'
}

{ #category : #'as yet unclassified' }
TostObjectStaticSubstitutionFormat class >> substitutions: aDictionary [
	^self new 
		substitutions: (aDictionary as: IdentityDictionary)
]

{ #category : #accessing }
TostObjectStaticSubstitutionFormat >> substitutions [
	^ substitutions
]

{ #category : #accessing }
TostObjectStaticSubstitutionFormat >> substitutions: anObject [
	substitutions := anObject
]

{ #category : #operations }
TostObjectStaticSubstitutionFormat >> tryWriteObject: anObject with: aTostTransporter [
	| substitution |
	substitution := substitutions at: anObject ifAbsent: [ ^false ].
	aTostTransporter writeSubstitution: substitution for: anObject format: id.
	^true
]
