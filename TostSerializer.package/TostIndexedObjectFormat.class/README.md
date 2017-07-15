I am an abstract format of objects which should be encoded by well known index.
My subclasses should define what part of object should be encoded like this. I provide simple implementation of this logic when full object is encoded by index. Subclasses should override it.

Instances of my subclasses are created on array of objects. Indexes dictionary is built according to objects position inside it. 
So on sender and receiver parts they should be created with same ordered objects set where indexes points to same things.

I encode objects with one byte which means that number of indexed objects is restricted to 255 items. If you need more you can create aditional format with extra objects set.

Internal Representation and Key Implementation Points.

    Instance Variables
	indexes:		<IdentityDictionary of<Object, Integer>>	"Object -> byteIndex"
	objects:		<Array>