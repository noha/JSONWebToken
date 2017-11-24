signature
checkSignature: parts
	((self signatureFor: ($. join: { parts first . parts second })) = parts third base64Decoded asByteArray) ifFalse: [
		Error signal: 'signature does not match' ].
