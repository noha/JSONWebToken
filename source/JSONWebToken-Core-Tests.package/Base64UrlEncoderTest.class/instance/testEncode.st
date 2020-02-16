tests
testEncode

	self assert: ( encoder encode: #[87 6 86 119 38 150 198 198 254 255] ) equals: 'VwZWdyaWxsb-_w=='