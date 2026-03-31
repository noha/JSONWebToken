Class {
	#name : 'JWAES256Test',
	#superclass : 'TestCase',
	#category : 'JSONWebToken-Core-Tests',
	#package : 'JSONWebToken-Core-Tests'
}

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
	signature := LargoJWAES256 signMessage: message withKey: privPem.

	"Tamper with signature"
	signature at: 1 put: (signature at: 1) + 1 \\ 256.

	parts at: 3 put: (Base64UrlEncoder new encode: signature).

	self should: [ LargoJWAES256 checkSignatureOfParts: parts withKey: pubPem ] raise: Error
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
	signature := LargoJWAES256 signMessage: message withKey: privPem.
	self assert: signature size equals: 64.

	parts at: 3 put: (Base64UrlEncoder new encode: signature).
	LargoJWAES256 checkSignatureOfParts: parts withKey: pubPem
]
