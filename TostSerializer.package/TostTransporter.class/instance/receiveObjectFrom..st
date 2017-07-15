api
receiveObjectFrom: aReadStream

	| materialization |
	materialization := TostMaterialization by: self on: aReadStream.
	^materialization materializeObject