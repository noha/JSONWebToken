sign
checkSignatureOfParts: parts withKey: key
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