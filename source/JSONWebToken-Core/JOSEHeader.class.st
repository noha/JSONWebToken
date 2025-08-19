"
Common superclass for Javascript Object Signing and Encryption headers (JOSE)
"
Class {
	#name : 'JOSEHeader',
	#superclass : 'Object',
	#instVars : [
		'properties'
	],
	#category : 'JSONWebToken-Core-Headers',
	#package : 'JSONWebToken-Core',
	#tag : 'Headers'
}

{ #category : 'as yet unclassified' }
JOSEHeader class >> neoJsonMapping: mapper [
	mapper for: self do: [ :mapping |
		mapping 
			mapInstVar: #type to: #typ;
			mapInstVar: #algorithm to: #alg ]
	
]

{ #category : 'comparing' }
JOSEHeader >> = aHeader [
	^ aHeader hasSameElements: properties
]

{ #category : 'accessing' }
JOSEHeader >> at: aKey [
	^ properties at: aKey
]

{ #category : 'accessing' }
JOSEHeader >> at: aKey put: aValue [
	properties at: aKey put: aValue
]

{ #category : 'testing' }
JOSEHeader >> hasSameElements: aDictionary [
	^ (properties difference: aDictionary) isEmpty
]

{ #category : 'comparing' }
JOSEHeader >> hash [
	^ properties hash
]

{ #category : 'accessing' }
JOSEHeader >> kid [
"Public Key ID"
	^ properties at: 'kid'
]

{ #category : 'accessing' }
JOSEHeader >> kid: anObject [
	properties at: 'kid' put: anObject
]

{ #category : 'accessing' }
JOSEHeader >> typ [
	^ self type
]

{ #category : 'accessing' }
JOSEHeader >> typ: aString [
	self type: aString
]

{ #category : 'accessing' }
JOSEHeader >> type [
	^ properties at: 'typ'
]

{ #category : 'accessing' }
JOSEHeader >> type: anObject [
	properties at: 'typ' put: anObject
]
