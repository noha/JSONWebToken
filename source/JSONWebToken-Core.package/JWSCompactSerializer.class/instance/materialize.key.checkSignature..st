reading
materialize: aString key: aKeyString checkSignature: checkSignature

	| parts header jws |

	parts := $. split: aString.
	(parts size = 3) ifFalse: [ JWSInvalidTokenFormat signal: 'the format of the token is invalid' ].
	header := JWSHeader fromJson: ( self class base64UrlDecoded: parts first ) utf8Decoded.
	jws := JsonWebSignature new
		key: aKeyString;
		setProtectedHeader: header.
	checkSignature
		ifTrue: [ jws checkSignature: parts ].
	^ jws payload: ( JWTClaimsSet fromJson: ( self class base64UrlDecoded: parts second ) utf8Decoded )