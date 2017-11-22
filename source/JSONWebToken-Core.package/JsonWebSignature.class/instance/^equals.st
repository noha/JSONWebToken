comparing
= aWebSignature
	^ (aWebSignature hasSameProtectedHeader: protectedHeader) and: [ 
		aWebSignature hasSamePayload: payload ] 