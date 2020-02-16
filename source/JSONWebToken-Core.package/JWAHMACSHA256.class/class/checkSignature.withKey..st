sign
checkSignature: parts withKey: key
	(self
		signMessage:
			($.
				join:
					{parts first.
					parts second}) withKey: key)
		= (Base64UrlEncoder new decode: parts third base64Padded)
		ifFalse: [ Error signal: 'signature does not match' ]