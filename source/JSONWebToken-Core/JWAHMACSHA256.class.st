"
HMAC SHA256 
"
Class {
	#name : 'JWAHMACSHA256',
	#superclass : 'JsonWebAlgorithm',
	#category : 'JSONWebToken-Core-Algorithms',
	#package : 'JSONWebToken-Core',
	#tag : 'Algorithms'
}

{ #category : 'sign' }
JWAHMACSHA256 class >> checkSignatureOfParts: parts withKey: key [
	(self
		signMessage:
			($.
				join:
					{parts first.
					parts second}) withKey: key)
		= (Base64UrlEncoder new decode: parts third base64Padded)
		ifFalse: [ Error signal: 'signature does not match' ]
]

{ #category : 'accessing' }
JWAHMACSHA256 class >> parameterValue [
	^ 'HS256'
]

{ #category : 'sign' }
JWAHMACSHA256 class >> signMessage: aString withKey: anObject [
	^ ((HMAC on: SHA256) 
		key: anObject asByteArray; 
		digestMessage: aString asByteArray)
]
