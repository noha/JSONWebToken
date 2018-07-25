writing
writePayload: anObject
	stream nextPutAll: anObject asJson asByteArray base64Encoded 