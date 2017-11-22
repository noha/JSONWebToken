as yet unclassified
fromJson: aString
	^ self new 
		setClaims: (NeoJSONReader fromString: aString)