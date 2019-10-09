tests
testUnsecuredJWT

	| jws tokenString materialized |

	jws := JsonWebSignature new
		algorithmName: 'none';
		payload: ( JWTClaimsSet new at: 'bar' put: 'foo' ).
	jws key: 'foobar'.

	tokenString := jws compactSerialized.

	materialized := JsonWebSignature materializeCompact: tokenString key: 'foobar'.

	self assert: jws equals: materialized