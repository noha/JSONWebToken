signature
checkSignature: parts

	
	self protectedHeader algorithm checkSignature: parts withKey: key
