tests
testDecode

	self assert: ( encoder decode: 'VwZWdyaWxsb-_w==' ) equals: #[87 6 86 119 38 150 198 198 254 255]