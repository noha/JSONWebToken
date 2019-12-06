signature
checkSignature: parts

	( self signatureFor:( $. join: {parts first. parts second} ) ) = ( self base64Decoded: parts third  )
		ifFalse: [ Error signal: 'signature does not match' ]