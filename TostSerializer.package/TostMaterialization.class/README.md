I implement object materialization.

I materialize objects step by step. First I read root and start iterate references by object traveler. For each reference (which are nil from begining) I read next object from stream and assign it to given reference.  Object travel iterates in breadth first direction. So at some point it will go deeply to next read object which will be materialized in same way as root. This loop will continue until traveler will traverse full object graph which should means end of object stream.

I implement low level decoding methods like readInteger or #readByte which are used for specific objects materialization.
Objects manage binary decoding of instances in class side method:
	createTostInstanceWith: aMaterialization
 
My processedObject dictionary contains all materialized objects as values and indexes inside stream as keys.
My processedClasses dictionary contains all classes of materialized objects as values and indexes inside stream as keys.

Public API and Key Messages

- materializeObject