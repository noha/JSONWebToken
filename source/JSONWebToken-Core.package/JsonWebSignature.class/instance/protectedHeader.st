accessing
protectedHeader
	^ protectedHeader ifNil: [ 
		protectedHeader := self headerClass new ]