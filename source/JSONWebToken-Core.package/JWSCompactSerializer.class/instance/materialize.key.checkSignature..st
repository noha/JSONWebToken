reading
materialize: aString key: aKeyString checkSignature: checkSignature
	| parts header jws  |
	parts := $. split: aString.
	header := JWSHeader fromJson: (parts at: 1) base64Decoded.
	jws := JsonWebSignature new
		key: aKeyString;
		setProtectedHeader: header.
	checkSignature ifTrue: [  
		jws checkSignature: parts  ]. 
	^ jws payload: (JWTClaimsSet fromJson: parts second base64Decoded) 