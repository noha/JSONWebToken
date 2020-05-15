sign
checkSignature: parts withKey: key
	| jwtHeaderAndPayload signatureByteArray rsa pubKey |
	jwtHeaderAndPayload := $.
		join:
			{parts first.
			parts second}.
	signatureByteArray := parts third base64Padded base64Decoded
		asByteArray.
	rsa := (key includesSubstring: 'BEGIN RSA PUBLIC KEY')
		ifTrue: [ LcRSA fromRsaPublicKeyPemString: key ]
		ifFalse: [ LcRSA fromPemString: key ].
	pubKey := LcEvpPublicKey setRSA: rsa.
	(pubKey
		digestVerifyMessage: jwtHeaderAndPayload
		with: signatureByteArray)
		ifFalse: [ Error signal: 'signature does not match' ]