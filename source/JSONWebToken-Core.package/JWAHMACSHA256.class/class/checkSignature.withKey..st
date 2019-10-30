sign
checkSignature: parts withKey: key
	(self
		signMessage:
			($.
				join:
					{parts first.
					parts second}) withKey: key)
		= parts third base64Padded base64Decoded asByteArray
		ifFalse: [ Error signal: 'signature does not match' ]