tests
testPadding

	self 
		assert: '4'   base64Padded equals: '4===';
		assert: '42'  base64Padded equals: '42==';
		assert: '424' base64Padded equals: '424=';
		assert: '4242' base64Padded equals: '4242'