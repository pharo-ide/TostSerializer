I am format for objects which belongs to well known classes. 
I encode such objects in the way where classes are encoded by one byte index instead of full name.
For example you could create compact format for nil, true and false:

	TostNewObjectOfWellKnownClassFormat on: { Array. OrderedCollection. String}. 

Number of well known classes is restricted to 255