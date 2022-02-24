sign
checkSignature: aString withKey: key
	| jwtHeaderAndPayload signatureByteArray publicKey tokenParts |
	tokenParts := $. split: aString.
	jwtHeaderAndPayload := $. join: (tokenParts first: 2).
	signatureByteArray := (Base64UrlEncoder new decode: tokenParts third base64Padded)
		asByteArray.
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