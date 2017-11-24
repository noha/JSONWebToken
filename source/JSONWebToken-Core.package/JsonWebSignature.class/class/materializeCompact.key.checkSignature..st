materializing
materializeCompact: aString key: aKeyString checkSignature: checkSignature
	^ JWSCompactSerializer new materialize: aString key: aKeyString checkSignature: checkSignature
		