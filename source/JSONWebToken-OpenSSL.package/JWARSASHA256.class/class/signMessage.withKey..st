sign
signMessage: message withKey: anObject
	| pkey sig |
	pkey := LcEvpPublicKey setRSA: (LcRSA fromPemString: anObject).
	message pinInMemory.
	sig := [ pkey digestSignMessage: message ]
		ensure: [ message unpinInMemory ].
	^ sig