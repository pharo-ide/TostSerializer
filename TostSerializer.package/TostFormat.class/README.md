I am a root of tost formats hierarhy. My subclasses should implement specific cases for objects serialization/materialization process.

For example they could define how to write completelly new object on stream or how to write duplicated object which was already written on stream or how to write new object which class was already written on stream during previous object serialization. 

Subclasses should implement two methods:

- tryWriteObject: anObject with: aSerialization
- readObjectWith: aMaterialization

Write method should decide if given object is approached for current format. And only if it really writes object on steams it should return true. Otherwise false. 
Read method should just read object assuming that object was really written by same format.

My id variable is byte which is used as preamble for any object encoding. It assigned to my by transporter.

Internal Representation and Key Implementation Points.

    Instance Variables
	id:		<SmallInteger>	"byte"