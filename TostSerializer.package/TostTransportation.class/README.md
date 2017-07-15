I am a root class for concrete transportation command. There are two subclasses:
	- TostSerialization
	- TostMaterialization
I define environment of objects which are used by them
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dataStream:		<Stream>
	objectIndex:		<Integert>
	processedClasses:		<IdentityDictionary>
	processedObjects:		<IdentityDictionary>
	transporter:		<TostTransporter>
	traveler:		<ObjectTraveler>