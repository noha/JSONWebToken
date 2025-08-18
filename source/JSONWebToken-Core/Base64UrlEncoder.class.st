"
I am encoder/decoder for base 64 using an alphabet that's URL and filename safe according to https://tools.ietf.org/html/rfc4648#page-5.

Base64 encoding is a technique to encode binary data as a string of characters that can be safely transported over various protocols. 
Basically, every 3 bytes are encoded using 4 characters from an alphabet of 64. Each encoded character represents 6 bits.


"
Class {
	#name : 'Base64UrlEncoder',
	#superclass : 'Object',
	#instVars : [
		'encoder'
	],
	#classVars : [
		'URLSafeAlphabet'
	],
	#category : 'JSONWebToken-Core-Serialization',
	#package : 'JSONWebToken-Core',
	#tag : 'Serialization'
}

{ #category : 'class initialization' }
Base64UrlEncoder class >> initialize [

	URLSafeAlphabet := String withAll: ( $A to: $Z ) , ( $a to: $z ) , ( $0 to: $9 ) , #($- $_)
]

{ #category : 'converting' }
Base64UrlEncoder >> decode: string [

	^ encoder decode: string
]

{ #category : 'converting' }
Base64UrlEncoder >> encode: byteArray [

	^ encoder encode: byteArray
]

{ #category : 'initialization' }
Base64UrlEncoder >> initialize [

	super initialize.
	encoder := ZnBase64Encoder new.
	encoder alphabet: URLSafeAlphabet
]
