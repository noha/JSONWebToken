Class {
	#name : 'JWAES256Test',
	#superclass : 'TestCase',
	#category : 'JSONWebToken-Core-Tests',
	#package : 'JSONWebToken-Core-Tests'
}

{ #category : 'test data' }
JWAES256Test >> getPayloadDictionary [

	^ {
		  ('sub' -> '1234567890').
		  ('name' -> 'ES256 Test User').
		  ('iat' -> 1775048930).
		  ('exp' -> 1775052530).
		  ('test_purpose' -> 'ES256 signing algorithm test') } asOrderedDictionary
]

{ #category : 'test data' }
JWAES256Test >> getPemPrivateKey [

	^ '-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIH9/APMoYm1tmblseTbersZ/0jbz4KoLFgYCA8kvU9tPoAoGCCqGSM49AwEHoUQDQgAE
5qbhpA+LJ+nDC4SrdOpQna193C6fmqJJzYnYCQJ6VL9I8mXceQ/RiZEZXmDK2HFACLxiwKp6nCgM
Hhhn/OMf9g==
-----END EC PRIVATE KEY-----'
]

{ #category : 'test data' }
JWAES256Test >> getPemPublicKey [

	^ '-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE5qbhpA+LJ+nDC4SrdOpQna193C6fmqJJzYnYCQJ6
VL9I8mXceQ/RiZEZXmDK2HFACLxiwKp6nCgMHhhn/OMf9g==
-----END PUBLIC KEY-----'
]

{ #category : 'tests' }
JWAES256Test >> testAssertPemStrings [

	| privateKey publicKey |
	privateKey := self getPemPrivateKey.
	publicKey := self getPemPublicKey.

	"Valid keys should not signal anything"
	JWAES256 assertPrivateKeyPemString: privateKey.
	JWAES256 assertPublicKeyPemString: publicKey.

	"Keys with whitespace should now be accepted because we trim them"
	JWAES256 assertPrivateKeyPemString: privateKey , ' '.
	JWAES256 assertPrivateKeyPemString: ' ' , privateKey.
	JWAES256 assertPublicKeyPemString: publicKey , ' '.
	JWAES256 assertPublicKeyPemString: ' ' , publicKey.

	"Invalid headers"
	self
		should: [ JWAES256 assertPrivateKeyPemString: '-----BEGIN WRONG KEY-----' ]
		raise: AssertionFailure.

	"Nil and empty"
	self should: [ JWAES256 assertPrivateKeyPemString: nil ] raise: AssertionFailure.
	self should: [ JWAES256 assertPrivateKeyPemString: '' ] raise: AssertionFailure.
	self should: [ JWAES256 assertPrivateKeyPemString: 123 ] raise: AssertionFailure
]

{ #category : 'tests' }
JWAES256Test >> testInvalidSignature [

	| privPem pubPem message signature parts |
	privPem := '-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIJMAmRbBAEzALqgw+fnF1iPFRXfeQO/3kKzw0Fr0kiVGoAoGCCqGSM49
AwEHoUQDQgAEAXizW3CKL9NeATTYgWuD7cE4s6F7Zsd10kEtEwclNb8dXqbx3x/O
x7uN34ptxuwIV4y6QmstfKDbIp9qlgDSfQ==
-----END EC PRIVATE KEY-----'.
	pubPem := '-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEAXizW3CKL9NeATTYgWuD7cE4s6F7
Zsd10kEtEwclNb8dXqbx3x/Ox7uN34ptxuwIV4y6QmstfKDbIp9qlgDSfQ==
-----END PUBLIC KEY-----'.

	parts := {
		         (Base64UrlEncoder new encode: 'header' asByteArray).
		         (Base64UrlEncoder new encode: 'payload' asByteArray).
		         '' }.
	message := parts first , '.' , parts second.
	signature := JWAES256 signMessage: message withKey: privPem.

	"Tamper with signature"
	signature at: 1 put: (signature at: 1) + 1 \\ 256.

	parts at: 3 put: (Base64UrlEncoder new encode: signature).

	self should: [ JWAES256 checkSignatureOfParts: parts withKey: pubPem ] raise: Error
]

{ #category : 'tests' }
JWAES256Test >> testSerializeAndDeserialize [

	| jws tokenString dic |
	jws := JsonWebSignature new
		       algorithm: JWAES256;
		       payload: JWTClaimsSet new;
		       yourself.
	jws header typ: 'JWT'.
	jws key: self getPemPrivateKey.
	jws payload setClaims: self getPayloadDictionary.
	tokenString := jws compactSerialized.

	jws := JsonWebSignature
		       materializeCompact: tokenString
		       key: self getPemPublicKey
		       checkSignature: true.
	dic := self getPayloadDictionary.
	self assert: (jws payload hasSameClaims: dic)
]

{ #category : 'tests' }
JWAES256Test >> testSignAndVerify [

	| privPem pubPem message signature parts |
	privPem := '-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIJMAmRbBAEzALqgw+fnF1iPFRXfeQO/3kKzw0Fr0kiVGoAoGCCqGSM49
AwEHoUQDQgAEAXizW3CKL9NeATTYgWuD7cE4s6F7Zsd10kEtEwclNb8dXqbx3x/O
x7uN34ptxuwIV4y6QmstfKDbIp9qlgDSfQ==
-----END EC PRIVATE KEY-----'.
	pubPem := '-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEAXizW3CKL9NeATTYgWuD7cE4s6F7
Zsd10kEtEwclNb8dXqbx3x/Ox7uN34ptxuwIV4y6QmstfKDbIp9qlgDSfQ==
-----END PUBLIC KEY-----'.

	parts := {
		         (Base64UrlEncoder new encode: 'header' asByteArray).
		         (Base64UrlEncoder new encode: 'payload' asByteArray).
		         '' }.
	message := parts first , '.' , parts second.
	signature := JWAES256 signMessage: message withKey: privPem.
	self assert: signature size equals: 64.

	parts at: 3 put: (Base64UrlEncoder new encode: signature).
	JWAES256 checkSignatureOfParts: parts withKey: pubPem
]
