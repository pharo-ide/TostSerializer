I am format for well known objects. I encode them by one byte index and manage serialization process to skip all internal structure.
For example you could create compact format for nil, true and false:

	TostWellKnownObjectFormat on: { nil. true. false} 

There is similar default instance on class side.

Number of well known objects is restricted to 255