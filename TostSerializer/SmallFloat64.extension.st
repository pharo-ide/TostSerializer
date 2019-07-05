Extension { #name : #SmallFloat64 }

{ #category : #'*TostSerializer' }
SmallFloat64 class >> createTostInstanceWith: aTostMaterialization [
	^ (BoxedFloat64 createTostInstanceWith: aTostMaterialization) * 1.0
]
