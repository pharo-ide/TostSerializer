tests-objects
testDictionary
	| dict actual key1 key2 |
	dict := Dictionary newFrom: {Object new -> #item1. Object new -> #item2}.
	self serialize: dict.	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Dictionary.
	"dictionary should be rehashed after materialization. So each key can access own value"
	key1 := actual keyAtValue: #item1.
	key2 := actual keyAtValue: #item2.
	actual should include: #item1 at: key1.
	actual should include: #item2 at: key2.