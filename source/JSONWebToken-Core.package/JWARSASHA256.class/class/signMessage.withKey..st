sign
signMessage: aString withKey: anObject
	| pkey sig |
	pkey := LcEvpPublicKey setRSA: (LcRSA fromPemString: anObject).
	sig := pkey digestSignMessage: aString.
	^ sig