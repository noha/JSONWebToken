"
JSON Web signature header
"
Class {
	#name : 'JWSHeader',
	#superclass : 'JWCryptoHeader',
	#category : 'JSONWebToken-Core-Headers',
	#package : 'JSONWebToken-Core',
	#tag : 'Headers'
}

{ #category : 'instance-creation' }
JWSHeader class >> fromJson: aString [ 
	^ self new 
		setProperties: (NeoJSONReader fromString: aString)
]

{ #category : 'testing' }
JWSHeader >> isEqualTo: aHeader [ 
	^ aHeader hasSameElements: properties
]
