instance creation
named: aString 
	^ self allSubclasses 
		detect: [ :each | each parameterValue = aString ]