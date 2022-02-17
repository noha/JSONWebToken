reading
materialize: aString key: aKeyString checkSignature: checkSignature

	| parts header jws |

	parts := $. split: aString.
	(parts size = 3) ifFalse: [ JWSInvalidTokenFormat signal: 'the format of the token is invalid' ].
	header := JWSHeader fromJson: ( self base64Decoded: parts first ) utf8Decoded.
	jws := JsonWebSignature new
		key: aKeyString;
		setProtectedHeader: header.
	checkSignature
		ifTrue: [ jws checkSignature: parts ].
	^ jws payload: ( JWTClaimsSet fromJson: ( self base64Decoded: parts second ) utf8Decoded )