as yet unclassified
neoJsonMapping: mapper
	mapper for: self do: [ :mapping |
		mapping 
			mapInstVar: #type to: #typ;
			mapInstVar: #algorithm to: #alg ]
	