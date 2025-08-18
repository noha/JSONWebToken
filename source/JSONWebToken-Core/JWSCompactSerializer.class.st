"
A JSON Web signature serializer serializing in a more
compact Base-64 encoded format (using double dispatching)

"
Class {
	#name : 'JWSCompactSerializer',
	#superclass : 'JWSSerializer',
	#category : 'JSONWebToken-Core-Serialization',
	#package : 'JSONWebToken-Core',
	#tag : 'Serialization'
}

{ #category : 'reading' }
JWSCompactSerializer >> materialize: aString key: aKeyString [
	^ self materialize: aString key: aKeyString checkSignature: true 
]

{ #category : 'reading' }
JWSCompactSerializer >> materialize: aString key: aKeyString checkSignature: checkSignature [

	| parts header jws |

	parts := $. split: aString.
	(parts size = 3) ifFalse: [ JWSInvalidTokenFormat signal: 'the format of the token is invalid' ].
	header := JWSHeader fromJson: ( self class base64UrlDecoded: parts first ) utf8Decoded.
	jws := JsonWebSignature new
		key: aKeyString;
		setProtectedHeader: header.
	checkSignature
		ifTrue: [ jws checkSignature: parts ].
	^ jws payload: ( JWTClaimsSet fromJson: ( self class base64UrlDecoded: parts second ) utf8Decoded )
]

{ #category : 'serialization' }
JWSCompactSerializer >> serialize: aWebSignature [
	| signature |
	aWebSignature writeProtectedHeaderOn: self.
	stream nextPut: $. .
	aWebSignature writePayloadOn: self.
	
	signature := aWebSignature signatureFor: stream contents.
	stream
		nextPut: $.;
		nextPutAll: (self class base64UrlEncoded: signature).
	^ stream contents
]

{ #category : 'writing' }
JWSCompactSerializer >> writeHeader: aHeader [ 
	stream nextPutAll: (self class base64UrlEncoded: aHeader asJson asByteArray) 

]

{ #category : 'writing' }
JWSCompactSerializer >> writePayload: anObject [
	stream nextPutAll: (self class base64UrlEncoded: anObject asJson utf8Encoded) 
]
