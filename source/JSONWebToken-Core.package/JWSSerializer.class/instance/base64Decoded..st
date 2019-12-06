conversion
base64Decoded: aBase64String

	"According to https://tools.ietf.org/html/rfc7519#page-4 the encoding needs to be base64Url.
	The padding can be stripped as it is not used for transport in JWT, so we need to pad it just in case"

	^ Base64UrlEncoder new decode: aBase64String base64Padded