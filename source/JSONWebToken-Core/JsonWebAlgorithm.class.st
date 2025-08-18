"
Abstract superclass for algorithms used for web encryption
"
Class {
	#name : 'JsonWebAlgorithm',
	#superclass : 'Object',
	#category : 'JSONWebToken-Core-Algorithms',
	#package : 'JSONWebToken-Core',
	#tag : 'Algorithms'
}

{ #category : 'sign' }
JsonWebAlgorithm class >> checkSignature: token withKey: key [
	"keep this method backward compatible also accepting already splitted parts"
	self 
		checkSignatureOfParts: (token isString 
			ifTrue: [ $. split: token ]
			ifFalse: [ token ])
		withKey: key
]

{ #category : 'sign' }
JsonWebAlgorithm class >> checkSignatureOfParts: parts withKey: key [
	self subclassResponsibility 
]

{ #category : 'testing' }
JsonWebAlgorithm class >> isAbstract [

	^self name = #JsonWebAlgorithm 
]

{ #category : 'instance creation' }
JsonWebAlgorithm class >> named: aString [ 
	^ self allSubclasses 
		detect: [ :each | each parameterValue = aString ]
]

{ #category : 'accessing' }
JsonWebAlgorithm class >> parameterValue [
	self shouldBeImplemented 
]
