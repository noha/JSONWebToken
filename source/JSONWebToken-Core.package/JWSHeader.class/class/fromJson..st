instance-creation
fromJson: aString 
	^ self new 
		setProperties: (NeoJSONReader fromString: aString)