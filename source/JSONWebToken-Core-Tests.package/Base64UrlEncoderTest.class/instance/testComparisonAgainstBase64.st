tests
testComparisonAgainstBase64

	self
		assert: #[87 6 86 119 38 150 198 198 254 255] base64Encoded equals: 'VwZWdyaWxsb+/w==';
		assert: ( encoder encode: #[87 6 86 119 38 150 198 198 254 255] ) equals: 'VwZWdyaWxsb-_w=='