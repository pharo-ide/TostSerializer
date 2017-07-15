*TostSerializer
writeTostBodyWith: aTostSerialization
 
	self class isVariable ifTrue: [ aTostSerialization writePositiveInteger: self size]