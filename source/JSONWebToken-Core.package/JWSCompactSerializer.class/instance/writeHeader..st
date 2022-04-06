writing
writeHeader: aHeader 
	stream nextPutAll: (self class base64UrlEncoded: aHeader asJson asByteArray) 
