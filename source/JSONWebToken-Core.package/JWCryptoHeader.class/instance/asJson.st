converting
asJson
	^ NeoJSONWriter toString: (properties copy at: 'alg' put: algorithm parameterValue; yourself)