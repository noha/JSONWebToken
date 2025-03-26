accessing - basic
at: aString

	^ strict
		  ifTrue: [ claims at: aString ]
		  ifFalse: [ claims at: aString ifAbsent: [  ] ]