conversion
base64Encoded: aByteArray

	"According to https://tools.ietf.org/html/rfc7519#page-4 the encoding needs to be base64Url.
	The padding is stripped as it is not used for transport in JWT"

	^ ( Base64UrlEncoder new encode: aByteArray ) copyWithoutAll: '='