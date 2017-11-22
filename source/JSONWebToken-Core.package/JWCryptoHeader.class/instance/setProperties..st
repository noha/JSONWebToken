accessing
setProperties: aDictionary 
	properties := aDictionary.
	(properties includesKey: 'alg') ifTrue: [ 
		algorithm := JsonWebAlgorithm named: (properties at: 'alg') ]