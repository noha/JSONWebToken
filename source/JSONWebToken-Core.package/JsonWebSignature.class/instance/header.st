accessing
header
	^ protectedHeader ifNil: [ 
		protectedHeader := self headerClass new ]