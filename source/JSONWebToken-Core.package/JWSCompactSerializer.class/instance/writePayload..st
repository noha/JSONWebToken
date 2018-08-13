writing
writePayload: anObject
	stream nextPutAll: (self base64Encoded: anObject asJson asByteArray) 