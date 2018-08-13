serialization
serialize: aWebSignature
	| signature |
	aWebSignature writeProtectedHeaderOn: self.
	stream nextPut: $. .
	aWebSignature writePayloadOn: self.
	
	signature := aWebSignature signatureFor: stream contents.
	stream
		nextPut: $.;
		nextPutAll: signature base64Encoded.
	^ stream contents