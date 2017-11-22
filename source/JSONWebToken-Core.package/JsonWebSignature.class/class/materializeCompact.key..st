materializing
materializeCompact: aString key: aKeyString
	^ JWSCompactSerializer new materialize: aString key: aKeyString
		