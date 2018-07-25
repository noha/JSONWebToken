*JSONWebToken-Core
base64Padded
	| paddedString |
	paddedString := ((self size \\ 4) = 0) 
		ifTrue: [ self ]
		ifFalse: [ 
			String streamContents: [ :stream | 
				stream nextPutAll: self. 
				(4 - (self size \\ 4)) timesRepeat: [ 
					stream nextPut: $= ] ] ].
	^ paddedString 