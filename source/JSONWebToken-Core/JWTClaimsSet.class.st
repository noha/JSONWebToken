"
A set of specific claims
"
Class {
	#name : 'JWTClaimsSet',
	#superclass : 'Object',
	#instVars : [
		'claims',
		'strict'
	],
	#category : 'JSONWebToken-Core-Base',
	#package : 'JSONWebToken-Core',
	#tag : 'Base'
}

{ #category : 'as yet unclassified' }
JWTClaimsSet class >> fromJson: aString [
	^ self new 
		setClaims: (NeoJSONReader fromString: aString)
]

{ #category : 'converting' }
JWTClaimsSet >> asJson [
	^ NeoJSONWriter toString: claims
]

{ #category : 'accessing - basic' }
JWTClaimsSet >> at: aString [

	^ strict
		  ifTrue: [ claims at: aString ]
		  ifFalse: [ claims at: aString ifAbsent: [  ] ]
]

{ #category : 'accessing - basic' }
JWTClaimsSet >> at: aString put: anObject [ 
	claims at: aString put: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> aud [
	^ self at: 'aud'
]

{ #category : 'accessing' }
JWTClaimsSet >> aud: aString [
	self at: 'aud' put: aString
]

{ #category : 'accessing' }
JWTClaimsSet >> audiences [
	^ self aud
]

{ #category : 'accessing' }
JWTClaimsSet >> audiences: anObject [
	self aud: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> authTime [
	^ self at: 'auth_time'
]

{ #category : 'accessing' }
JWTClaimsSet >> authTime: anObject [
	self at: 'auth_time' put: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> authenticationContextClassReference [
	^ self at: 'acr'
]

{ #category : 'accessing' }
JWTClaimsSet >> authenticationContextClassReference: anObject [
	self at: 'acr' put: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> authenticationMethodsReference [
	^ self at: 'amr'
]

{ #category : 'accessing' }
JWTClaimsSet >> authenticationMethodsReference: anObject [
	self at: 'amr' put: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> authorizedParty [
	^ self at: 'azp'
]

{ #category : 'accessing' }
JWTClaimsSet >> authorizedParty: anObject [
	self at: 'azp' put: anObject
]

{ #category : 'public' }
JWTClaimsSet >> beLenient [

	strict := false
]

{ #category : 'public' }
JWTClaimsSet >> beStrict [

	strict := true
]

{ #category : 'accessing' }
JWTClaimsSet >> claims [
	^ claims
]

{ #category : 'accessing' }
JWTClaimsSet >> exp [
	^ self expirationTime
]

{ #category : 'accessing' }
JWTClaimsSet >> exp: aNumber [
	self expirationTime: aNumber
]

{ #category : 'accessing' }
JWTClaimsSet >> expirationTime [
	^ self at: 'exp'
]

{ #category : 'accessing' }
JWTClaimsSet >> expirationTime: anObject [
	self at: 'exp' put: anObject
]

{ #category : 'testing' }
JWTClaimsSet >> hasSameClaims: aDictionary [
	^ (claims difference: aDictionary) isEmpty
]

{ #category : 'testing' }
JWTClaimsSet >> hasSameElements: anObject [
	^ anObject hasSameClaims: claims
]

{ #category : 'accessing' }
JWTClaimsSet >> iat [
	^ self at: 'iat'
]

{ #category : 'accessing' }
JWTClaimsSet >> iat: anObject [
	self at: 'iat' put: anObject
]

{ #category : 'initialize' }
JWTClaimsSet >> initialize [
	super initialize.
	claims := Dictionary new.
	strict := true
]

{ #category : 'accessing' }
JWTClaimsSet >> iss [
	^ self at: 'iss'
]

{ #category : 'accessing' }
JWTClaimsSet >> iss: aString [
	self at: 'iss' put: aString
]

{ #category : 'accessing' }
JWTClaimsSet >> issuedAt [
	^ self iat
]

{ #category : 'accessing' }
JWTClaimsSet >> issuedAt: anObject [
	self iat: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> issuer [
	^ self iss
]

{ #category : 'accessing' }
JWTClaimsSet >> issuer: anObject [
	self iss: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> mimeType [
	^ 'JWT'
]

{ #category : 'accessing' }
JWTClaimsSet >> nonce [
	^ self at: 'nonce'
]

{ #category : 'accessing' }
JWTClaimsSet >> nonce: anObject [
	self at: 'nonce' put: anObject
]

{ #category : 'accessing' }
JWTClaimsSet >> setClaims: aCollection [
	claims := aCollection
]

{ #category : 'accessing' }
JWTClaimsSet >> sub [
	^ self at: 'sub'
]

{ #category : 'accessing' }
JWTClaimsSet >> sub: aString [
	self at: 'sub' put: aString
]

{ #category : 'accessing' }
JWTClaimsSet >> subject [
	^ self sub
]

{ #category : 'accessing' }
JWTClaimsSet >> subject: anObject [
	self sub: anObject
]
