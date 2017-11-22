testing
hasSamePayload: aPayload
	aPayload ifNil: [ ^ false ].
	^ aPayload hasSameElements: payload