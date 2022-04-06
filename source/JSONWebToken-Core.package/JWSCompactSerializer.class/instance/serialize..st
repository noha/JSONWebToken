serialization
serialize: aWebSignature
	| signature |
	aWebSignature writeProtectedHeaderOn: self.
	stream nextPut: $. .
	aWebSignature writePayloadOn: self.
	
	signature := aWebSignature signatureFor: stream contents.
	stream
		nextPut: $.;
		nextPutAll: (self class base64UrlEncoded: signature).
	^ stream contents