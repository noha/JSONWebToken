writing
writePayload: anObject
	stream nextPutAll: (self class base64UrlEncoded: anObject asJson asByteArray) 