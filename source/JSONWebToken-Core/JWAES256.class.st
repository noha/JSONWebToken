"
I am an implementation of the ES256 (ECDSA with P-256 and SHA-256) JWT signing algorithm.

I use the OpenSSL EVP interface through LcEvpPublicKey for signing and verification.
Since the ES256 standard requires the signature to be a 64-byte concatenation of R and S, and OpenSSL uses the DER format, I provide the necessary conversion logic.

Example usage:
```pharo
signature := JWAES256 signMessage: 'message' withKey: ecPrivatePemKey.
JWAES256 checkSignatureOfParts: { header . payload . signature } withKey: ecPublicPemKey.
```
"
Class {
	#name : 'JWAES256',
	#superclass : 'JsonWebAlgorithm',
	#category : 'JSONWebToken-Core-Algorithms',
	#package : 'JSONWebToken-Core',
	#tag : 'Algorithms'
}

{ #category : 'sign' }
JWAES256 class >> checkSignatureOfParts: parts withKey: key [

	| jwtHeaderAndPayload signatureByteArray publicKey derSignature |
	jwtHeaderAndPayload := $. join: {
			                       parts first.
			                       parts second }.
	signatureByteArray := Base64UrlEncoder new decode: parts third base64Padded.

	"ES256 signature is 64 bytes (R | S). OpenSSL needs it in DER format."
	derSignature := self rsToDer: signatureByteArray.

	publicKey := LcEvpPublicKey fromPublicKeyPemString: key.

	jwtHeaderAndPayload pinInMemory.
	derSignature pinInMemory.
	[
		(publicKey digestVerifyMessage: jwtHeaderAndPayload asByteArray with: derSignature)
			ifFalse: [ Error signal: 'signature does not match' ] ] ensure: [
			jwtHeaderAndPayload unpinInMemory.
			derSignature unpinInMemory ]
]

{ #category : 'private' }
JWAES256 class >> copyInteger: source into: target startingAt: targetOffset [

	| srcOffset len |
	srcOffset := 1.
	len := source size.
	"Strip leading zeros if it makes it longer than 32"
	[ len > 32 and: [ (source at: srcOffset) = 0 ] ] whileTrue: [
			srcOffset := srcOffset + 1.
			len := len - 1 ].

	"If still longer than 32, it's an error for ES256 (P-256)"
	len > 32 ifTrue: [ Error signal: 'Integer too large for ES256' ].

	"Copy and pad with leading zeros if needed"
	target
		replaceFrom: targetOffset + (32 - len)
		to: targetOffset + 31
		with: source
		startingAt: srcOffset
]

{ #category : 'private' }
JWAES256 class >> derIntegerFor: aByteArray [

	| firstByte srcOffset |
	srcOffset := 1.
	"Strip leading zeros"
	[ srcOffset < aByteArray size and: [ (aByteArray at: srcOffset) = 0 ] ] whileTrue: [
		srcOffset := srcOffset + 1 ].

	firstByte := aByteArray at: srcOffset.
	firstByte > 127 ifTrue: [
		^ #[ 0 ] , (aByteArray copyFrom: srcOffset to: aByteArray size) ].
	^ aByteArray copyFrom: srcOffset to: aByteArray size
]

{ #category : 'private' }
JWAES256 class >> derToRS: derSignature [

	| r s offset lenR lenS rs |
	"DER: 30 L 02 LR R 02 LS S"
	(derSignature at: 1) = 16r30 ifFalse: [ Error signal: 'Invalid DER signature' ].
	offset := 3.
	(derSignature at: offset) = 16r02 ifFalse: [ Error signal: 'Invalid DER signature (R)' ].
	lenR := derSignature at: offset + 1.
	r := derSignature copyFrom: offset + 2 to: offset + 1 + lenR.

	offset := offset + 2 + lenR.
	(derSignature at: offset) = 16r02 ifFalse: [ Error signal: 'Invalid DER signature (S)' ].
	lenS := derSignature at: offset + 1.
	s := derSignature copyFrom: offset + 2 to: offset + 1 + lenS.

	rs := ByteArray new: 64.
	"If R is > 32 bytes (leading zero), strip it. If < 32 bytes, pad it."
	self copyInteger: r into: rs startingAt: 1.
	self copyInteger: s into: rs startingAt: 33.

	^ rs
]

{ #category : 'accessing' }
JWAES256 class >> parameterValue [

	^ 'ES256'
]

{ #category : 'private' }
JWAES256 class >> rsToDer: aByteArray [

	| r s derR derS result offset |
	r := aByteArray copyFrom: 1 to: 32.
	s := aByteArray copyFrom: 33 to: 64.

	derR := self derIntegerFor: r.
	derS := self derIntegerFor: s.

	result := ByteArray new: derR size + derS size + 6.
	result at: 1 put: 16r30. "Sequence"
	result at: 2 put: derR size + derS size + 4.

	offset := 3.
	result at: offset put: 16r02. "Integer"
	result at: offset + 1 put: derR size.
	result
		replaceFrom: offset + 2
		to: offset + 1 + derR size
		with: derR
		startingAt: 1.

	offset := offset + 2 + derR size.
	result at: offset put: 16r02. "Integer"
	result at: offset + 1 put: derS size.
	result
		replaceFrom: offset + 2
		to: offset + 1 + derS size
		with: derS
		startingAt: 1.

	^ result
]

{ #category : 'sign' }
JWAES256 class >> signMessage: message withKey: anObject [

	| pkey derSig |
	pkey := LcEvpPublicKey fromPrivateKeyPemString: anObject.
	message pinInMemory.
	derSig := [ pkey digestSignMessage: message asByteArray ] ensure: [
		          message unpinInMemory ].

	"OpenSSL returns DER format. ES256 requires 64 bytes (R | S)."
	^ self derToRS: derSig
]
