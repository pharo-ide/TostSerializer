"
I am an example of object with reference (my #content variable) suitable for Tost tests.
My instances can be created using #with: message: 
	
	MyTestContainer with: 10@30
 
Internal Representation and Key Implementation Points.

    Instance Variables
	content:		<Object>
"
Class {
	#name : #TostTestContainer,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'TostSerializer-Tests'
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
