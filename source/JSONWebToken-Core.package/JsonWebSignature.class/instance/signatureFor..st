signing
signatureFor: aString 
	^ self protectedHeader algorithm 
		signMessage: aString withKey: key