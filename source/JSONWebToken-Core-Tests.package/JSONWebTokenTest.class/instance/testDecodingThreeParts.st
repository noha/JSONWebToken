tests
testDecodingThreeParts 
	| tokenString invalid |
	tokenString := self simpleTokenString.
	invalid := $. join: ($. split: tokenString) allButLast.
	self 
		should: [ JsonWebSignature materializeCompact: invalid key: 'foobar' ]
		raise: JWSInvalidTokenFormat.