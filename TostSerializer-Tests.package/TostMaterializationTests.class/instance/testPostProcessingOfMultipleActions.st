tests-objects
testPostProcessingOfMultipleActions
	"it should cover the case when last post processing action is evaluated but not removed.
	For example array with two sets will require two rehashing as post processing"
	| actual item1 item2 set1 set2 |
	self serialize: {
		Set new addAll: {Object new. Object new}; yourself.
		Set new addAll: {Object new. Object new}; yourself}.	
	actual := materializer materializeObject.
	set1 := actual first.
	item1 := set1 asArray first.
	item2 := set1 asArray last.
	set1 should include: item1.
	set1 should include: item2.
	
	set2 := actual first.
	item1 := set2 asArray first.
	item2 := set2 asArray last.
	set2 should include: item1.
	set2 should include: item2