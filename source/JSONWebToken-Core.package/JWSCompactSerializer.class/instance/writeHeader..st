as yet unclassified
writeHeader: aHeader 
	stream nextPutAll:  aHeader asJson asByteArray base64Encoded 