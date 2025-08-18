"
Unit tests for JSON web tokens
"
Class {
	#name : 'JSONWebTokenTest',
	#superclass : 'TestCase',
	#category : 'JSONWebToken-Core-Tests',
	#package : 'JSONWebToken-Core-Tests'
}

{ #category : 'as yet unclassified' }
JSONWebTokenTest >> simpleJsonWebSignature [
	^ JsonWebSignature new
			algorithmName: 'HS256';
			payload: (JWTClaimsSet new
				at: 'bar' put: 'foo');
			key: 'foobar'
]

{ #category : 'as yet unclassified' }
JSONWebTokenTest >> simpleTokenString [
	^ self simpleJsonWebSignature compactSerialized.
]

{ #category : 'tests' }
JSONWebTokenTest >> testDecodingThreeParts [ 
	| tokenString invalid |
	tokenString := self simpleTokenString.
	invalid := $. join: ($. split: tokenString) allButLast.
	self 
		should: [ JsonWebSignature materializeCompact: invalid key: 'foobar' ]
		raise: JWSInvalidTokenFormat.
]

{ #category : 'tests' }
JSONWebTokenTest >> testEncoding [

	"This test verifies the token serialization against https://jwt.io/"

	| jws tokenString |

	jws := JsonWebSignature new
		algorithmName: 'HS256';
		payload:
			( JWTClaimsSet new
				at: 'scope'
					put:
					'read:operations read:metrics execute:health-check read:application-info execute:application-control read:application-configuration';
				yourself ).
	jws key: '69YLYMC02jLExrrkcR@NhrZaj%Xw^VFfK*r34uRWvl3e91N3es'.

	tokenString := jws compactSerialized.

	self
		assert: tokenString
		equals:
			'eyJhbGciOiJIUzI1NiJ9.eyJzY29wZSI6InJlYWQ6b3BlcmF0aW9ucyByZWFkOm1ldHJpY3MgZXhlY3V0ZTpoZWFsdGgtY2hlY2sgcmVhZDphcHBsaWNhdGlvbi1pbmZvIGV4ZWN1dGU6YXBwbGljYXRpb24tY29udHJvbCByZWFkOmFwcGxpY2F0aW9uLWNvbmZpZ3VyYXRpb24ifQ.-3meQq_ATpkE4FwFefP0AEBrFh9_llQxVXjnf-HLrIU'
]

{ #category : 'tests' }
JSONWebTokenTest >> testPadding [

	self 
		assert: '4'   base64Padded equals: '4===';
		assert: '42'  base64Padded equals: '42==';
		assert: '424' base64Padded equals: '424=';
		assert: '4242' base64Padded equals: '4242'
]

{ #category : 'tests' }
JSONWebTokenTest >> testRoundtrip [
	| jws tokenString materialized |
	
	jws := JsonWebSignature new
				algorithmName: 'HS256';
				payload: (JWTClaimsSet new
				at: 'bar' put: 'foo').
	jws key: 'foobar'.
	
	tokenString := jws compactSerialized.
	
	materialized := JsonWebSignature materializeCompact: tokenString key: 'foobar'.

	self assert: jws equals: materialized

]

{ #category : 'tests' }
JSONWebTokenTest >> testUnsecuredJWT [

	| jws tokenString materialized |

	jws := JsonWebSignature new
		algorithmName: 'none';
		payload: ( JWTClaimsSet new at: 'bar' put: 'foo' ).
	jws key: 'foobar'.

	tokenString := jws compactSerialized.

	materialized := JsonWebSignature materializeCompact: tokenString key: 'foobar'.

	self assert: jws equals: materialized
]
