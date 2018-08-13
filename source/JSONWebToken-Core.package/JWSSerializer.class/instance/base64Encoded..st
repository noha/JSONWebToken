conversion
base64Encoded: aByteArray
	"base64 encode and strip padding as it is not used for transport 
	in JWT"
	^ aByteArray base64Encoded copyWithoutAll: '='