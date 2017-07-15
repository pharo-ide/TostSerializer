running
setUp
	super setUp.
	
	dataStream := ByteArray new writeStream.
	serialization := TostSerialization by: transporter on: dataStream