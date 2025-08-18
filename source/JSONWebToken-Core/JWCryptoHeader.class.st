"
Common superclass for encrypted headers
"
Class {
	#name : 'JWCryptoHeader',
	#superclass : 'JOSEHeader',
	#instVars : [
		'algorithm'
	],
	#category : 'JSONWebToken-Core-Headers',
	#package : 'JSONWebToken-Core',
	#tag : 'Headers'
}

{ #category : 'accessing' }
JWCryptoHeader >> alg [
	^ properties at: 'alg'
]

{ #category : 'accessing' }
JWCryptoHeader >> alg: anObject [
	properties at: 'alg' put: anObject
]

{ #category : 'accessing' }
JWCryptoHeader >> algorithm [
	^ algorithm
]

{ #category : 'accessing' }
JWCryptoHeader >> algorithm: anObject [
	algorithm := anObject.
	self alg: anObject parameterValue 
]

{ #category : 'converting' }
JWCryptoHeader >> asJson [
	^ NeoJSONWriter toString: (properties copy at: 'alg' put: algorithm parameterValue; yourself)
]

{ #category : 'accessing' }
JWCryptoHeader >> contentType: aString [
	properties at: 'typ' put: aString
]

{ #category : 'initialization' }
JWCryptoHeader >> initialize [
	super initialize.
	properties := SmallDictionary new
]

{ #category : 'accessing' }
JWCryptoHeader >> registeredHeaders [
	^ #( typ cty )
]

{ #category : 'accessing' }
JWCryptoHeader >> setProperties: aDictionary [ 
	properties := aDictionary.
	(properties includesKey: 'alg') ifTrue: [ 
		algorithm := JsonWebAlgorithm named: (properties at: 'alg') ]
]
