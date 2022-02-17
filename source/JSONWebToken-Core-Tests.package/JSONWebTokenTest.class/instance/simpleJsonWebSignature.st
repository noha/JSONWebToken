as yet unclassified
simpleJsonWebSignature
	^ JsonWebSignature new
			algorithmName: 'HS256';
			payload: (JWTClaimsSet new
				at: 'bar' put: 'foo');
			key: 'foobar'