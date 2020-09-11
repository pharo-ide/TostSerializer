Extension { #name : #SmallFloat64 }

{ #category : #'*TostSerializer' }
SmallFloat64 class >> createTostInstanceWith: aTostTransporter [
	^ (BoxedFloat64 createTostInstanceWith: aTostTransporter) * 1.0
]
