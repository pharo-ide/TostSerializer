tests-objects
testBitmapInstance

	| actual |
	self serialize: (Bitmap withAll: #(1 2 5 10)).
	
	actual := materializer materializeObject.
	
	actual should beInstanceOf: Bitmap.
	actual should equalInOrder: #(1 2 5 10)