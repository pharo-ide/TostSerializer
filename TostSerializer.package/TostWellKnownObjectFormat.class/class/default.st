accessing
default
	^default ifNil: [ default := TostWellKnownObjectFormat on: { nil. true. false. 0. 1 }]