signature
checkSignature: aString
	| token |
	token := (aString isString not) 
		ifTrue: [ 
			"this seems to be the old usage handing out the parts collection so resemble"
			$. join: aString  ]
		ifFalse: [ aString ].
	
	self protectedHeader algorithm checkSignature: token withKey: key
