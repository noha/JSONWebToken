sign
signMessage: aString withKey: anObject
	^ ((HMAC on: SHA256) 
		key: anObject asByteArray; 
		digestMessage: aString asByteArray)