"
JSON Web signature serializer
"
Class {
	#name : 'JWSSerializer',
	#superclass : 'Object',
	#instVars : [
		'stream'
	],
	#category : 'JSONWebToken-Core-Serialization',
	#package : 'JSONWebToken-Core',
	#tag : 'Serialization'
}

{ #category : 'conversion' }
JWSSerializer class >> base64UrlDecoded: aBase64String [

	"According to https://tools.ietf.org/html/rfc7519#page-4 the encoding needs to be base64Url.
	The padding can be stripped as it is not used for transport in JWT, so we need to pad it just in case"

	^ Base64UrlEncoder new decode: aBase64String base64Padded
]

{ #category : 'conversion' }
JWSSerializer class >> base64UrlEncoded: aByteArray [

	"According to https://tools.ietf.org/html/rfc7519#page-4 the encoding needs to be base64Url.
	The padding is stripped as it is not used for transport in JWT"

	^ ( Base64UrlEncoder new encode: aByteArray ) copyWithoutAll: '='
]

{ #category : 'as yet unclassified' }
JWSSerializer class >> toJson: anObject [
	^ NeoJSONWriter toString: anObject
]

{ #category : 'initialization' }
JWSSerializer >> initialize [
	super initialize.
	stream := String new writeStream.
]
