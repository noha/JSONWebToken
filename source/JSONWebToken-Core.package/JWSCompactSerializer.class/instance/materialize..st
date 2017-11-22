reading
materialize: aString 
	| parts jws |
	parts := $. split: aString.
	jws := JWSHeader fromJson: (parts at: 1) base64Decoded.
	self halt.
		