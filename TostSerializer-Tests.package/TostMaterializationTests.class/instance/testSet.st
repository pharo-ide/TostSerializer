tests-objects
testSet
	| set actual item1 item2 |
	set := Set new. 
	set add: Object new; add: Object new.
	self serialize: set.	
	actual := materializer materializeObject.
	actual should beInstanceOf: Set.
	"set should be rehashed after materialization. So set should see that each item is included"
	item1 := actual asArray first.
	item2 := actual asArray last.
	actual should include: item1.
	actual should include: item2.