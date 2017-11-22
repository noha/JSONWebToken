writing
writePayload: anObject
	stream nextPutAll: anObject asJson base64Encoded 