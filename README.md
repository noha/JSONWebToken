# JSONWebToken for Pharo

## Overview

Implementation of a JSON web token following [RFC 7519](https://tools.ietf.org/html/rfc7519) for [Pharo](http://www.pharo.org).

## Installation

in your Pharo environment (Pharo 6 or higher) evaluate

```Smalltalk
Metacello new
      baseline:'JSONWebToken';
      repository: 'github://noha/JSONWebToken:master/source';
      load
```

## Usage

The class *JSONWebTokenTest* demonstrates how to encode/serialize a web signature to a token string using compact base 64 notation 
as well as deserialization:

```Smalltalk
testRoundtrip
	| jws tokenString materialized |
	
	jws := JsonWebSignature new
		algorithmName: 'HS256';
		payload: (JWTClaimsSet new
			at: 'bar' put: 'foo').
	jws key: 'foobar'.
	
	tokenString := jws compactSerialized.
	materialized := JsonWebSignature materializeCompact: tokenString key: 'foobar'.
	self assert: jws equals: materialized

```

## Further Infos
- [JWT, JWS and JWE for Not So Dummies!](https://medium.facilelogin.com/jwt-jws-and-jwe-for-not-so-dummies-b63310d201a3)
