"
An empty algorithm for not signing
"
Class {
	#name : 'JWANone',
	#superclass : 'JsonWebAlgorithm',
	#category : 'JSONWebToken-Core-Algorithms',
	#package : 'JSONWebToken-Core',
	#tag : 'Algorithms'
}

{ #category : 'sign' }
JWANone class >> checkSignatureOfParts: parts withKey: key [
	
]

{ #category : 'accessing' }
JWANone class >> parameterValue [
	^ 'none'
]

{ #category : 'signing' }
JWANone class >> signMessage: aString withKey: aKeyString [
	^ #[]
]
