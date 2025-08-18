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

{ #category : 'testing' }
JOSEHeader >> hasSameElements: aDictionary [
	^ (properties difference: aDictionary) isEmpty
]

{ #category : 'comparing' }
JOSEHeader >> hash [
	^ properties hash
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
