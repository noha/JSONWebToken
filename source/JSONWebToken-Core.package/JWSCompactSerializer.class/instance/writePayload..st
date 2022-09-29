writing
writePayload: anObject
	stream nextPutAll: (self class base64UrlEncoded: anObject asJson utf8Encoded) 