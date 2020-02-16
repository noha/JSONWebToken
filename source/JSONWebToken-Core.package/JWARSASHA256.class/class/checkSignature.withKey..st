sign
checkSignature: parts withKey: key
	| jwtHeaderAndPayload signatureByteArray rsa pubKey |
	jwtHeaderAndPayload := $.
		join:
			{parts first.
			parts second}.
	signatureByteArray := parts third base64Padded base64Decoded
		asByteArray.
	rsa := LcRSA fromRsaPublicKeyPemString: key.
	pubKey := LcEvpPublicKey setRSA: rsa.

			(pubKey
				digestVerifyMessage: jwtHeaderAndPayload
				with: signatureByteArray) ifFalse: [ Error signal: 'signature does not match' ]