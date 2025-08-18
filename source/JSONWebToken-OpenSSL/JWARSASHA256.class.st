"
RSA SHA256 
"
Class {
	#name : 'JWARSASHA256',
	#superclass : 'JsonWebAlgorithm',
	#category : 'JSONWebToken-OpenSSL',
	#package : 'JSONWebToken-OpenSSL'
}

{ #category : 'sign' }
JWARSASHA256 class >> checkSignatureOfParts: parts withKey: key [
	| jwtHeaderAndPayload signatureByteArray publicKey |
	jwtHeaderAndPayload := $.
		join:
			{parts first.
			parts second}.
	signatureByteArray := JWSSerializer base64UrlDecoded: parts third "base64Padded base64Decoded".
	publicKey := (key includesSubstring: 'BEGIN RSA PUBLIC KEY')
		ifTrue: [ LcEvpPublicKey setRSA:  (LcRSA fromRsaPublicKeyPemString: key) ]
		ifFalse: [ LcEvpPublicKey fromPublicKeyPemString: key ].
	jwtHeaderAndPayload pinInMemory.
	signatureByteArray pinInMemory.
	[ (publicKey
		digestVerifyMessage: jwtHeaderAndPayload
		with: signatureByteArray)
		ifFalse: [ Error signal: 'signature does not match' ] ]
		ensure: [ 
			jwtHeaderAndPayload unpinInMemory.
			signatureByteArray unpinInMemory  ]
]

{ #category : 'accessing' }
JWARSASHA256 class >> parameterValue [
	^ 'RS256'
]

{ #category : 'sign' }
JWARSASHA256 class >> signMessage: message withKey: anObject [
	| pkey sig |
	pkey := LcEvpPublicKey setRSA: (LcRSA fromPemString: anObject).
	message pinInMemory.
	sig := [ pkey digestSignMessage: message ]
		ensure: [ message unpinInMemory ].
	^ sig
]
