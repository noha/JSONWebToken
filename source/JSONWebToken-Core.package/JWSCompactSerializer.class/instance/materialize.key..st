reading
materialize: aString key: aKeyString
	| parts header jws  |
	parts := $. split: aString.
	header := JWSHeader fromJson: (parts at: 1) base64Decoded.
	jws := JsonWebSignature new
		key: aKeyString;
		setProtectedHeader: header.
	((jws signatureFor: ($. join: { parts first . parts second })) = parts third base64Decoded asByteArray) ifFalse: [
		Error signal: 'signature does not match' ].
	^ jws payload: (JWTClaimsSet fromJson: parts second base64Decoded) 