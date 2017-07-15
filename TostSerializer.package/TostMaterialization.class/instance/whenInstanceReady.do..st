post processing
whenInstanceReady: anObject do: actionBlock
	"When anObject created from stream it can require post processing action.
	I execute them when traveler left given object 
	which means that anObject graph is completally read from stream"
	postProcessingActions ifNil: [ postProcessingActions := IdentityDictionary new].
	
	postProcessingActions at: anObject put: actionBlock