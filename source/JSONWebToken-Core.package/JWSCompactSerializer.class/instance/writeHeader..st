as yet unclassified
writeHeader: aHeader 
	stream nextPutAll:  aHeader asJson base64Encoded 