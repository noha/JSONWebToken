tests
testEncoding

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