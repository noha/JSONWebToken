sign
checkSignature: aString withKey: key
	| tokenParts |
	tokenParts := $. split: aString.
	(self
		signMessage: ($. join: (tokenParts first: 2)) 
		withKey: key)
		= (Base64UrlEncoder new decode: tokenParts third base64Padded)
		ifFalse: [ Error signal: 'signature does not match' ]