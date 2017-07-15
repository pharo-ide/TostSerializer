running
setUp
	super setUp.
	
	transporter := TostTransporter formats: {
		TostDuplicatedObjectFormat new.
		TostNewObjectOfDuplicatedClassFormat new.
		TostNewObjectOfNewClassFormat new
	}