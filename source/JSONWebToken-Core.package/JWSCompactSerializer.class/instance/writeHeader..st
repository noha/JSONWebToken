writing
writeHeader: aHeader 
	stream nextPutAll: (self base64Encoded: aHeader asJson asByteArray) 
