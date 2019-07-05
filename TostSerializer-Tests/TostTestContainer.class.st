Class {
	#name : #TostTestContainer,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : 'TostSerializer-Tests'
}

{ #category : #'instance creation' }
TostTestContainer class >> with: anObject [
	^self new 
		content: anObject
]

{ #category : #accessing }
TostTestContainer >> content [
	^ content
]

{ #category : #accessing }
TostTestContainer >> content: anObject [
	content := anObject
]
