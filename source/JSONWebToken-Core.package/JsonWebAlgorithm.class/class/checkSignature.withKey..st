sign
checkSignature: token withKey: key
	"keep this method backward compatible also accepting already splitted parts"
	self 
		checkSignatureOfParts: (token isString 
			ifTrue: [ $. split: token ]
			ifFalse: [ token ])
		withKey: key