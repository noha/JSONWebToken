signature
checkSignature: parts
	((self signatureFor: ($. join: { parts first . parts second })) = parts third base64Padded base64Decoded) ifFalse: [
		Error signal: 'signature does not match' ].
