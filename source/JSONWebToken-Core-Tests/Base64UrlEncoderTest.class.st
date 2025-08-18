"
A Base64UrlEncoderTest is a test class for testing the behavior of Base64UrlEncoder
"
Class {
	#name : 'Base64UrlEncoderTest',
	#superclass : 'TestCase',
	#instVars : [
		'encoder'
	],
	#category : 'JSONWebToken-Core-Tests',
	#package : 'JSONWebToken-Core-Tests'
}

{ #category : 'running' }
Base64UrlEncoderTest >> setUp [

	super setUp.
	encoder := Base64UrlEncoder new
]

{ #category : 'tests' }
Base64UrlEncoderTest >> testComparisonAgainstBase64 [

	self
		assert: #[87 6 86 119 38 150 198 198 254 255] base64Encoded equals: 'VwZWdyaWxsb+/w==';
		assert: ( encoder encode: #[87 6 86 119 38 150 198 198 254 255] ) equals: 'VwZWdyaWxsb-_w=='
]

{ #category : 'tests' }
Base64UrlEncoderTest >> testDecode [

	self assert: ( encoder decode: 'VwZWdyaWxsb-_w==' ) equals: #[87 6 86 119 38 150 198 198 254 255]
]

{ #category : 'tests' }
Base64UrlEncoderTest >> testEncode [

	self assert: ( encoder encode: #[87 6 86 119 38 150 198 198 254 255] ) equals: 'VwZWdyaWxsb-_w=='
]
