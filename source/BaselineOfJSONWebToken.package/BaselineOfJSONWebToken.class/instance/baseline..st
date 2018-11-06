baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec baseline: 'NeoJSON' 
			with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ].
		spec 
			package: #'JSONWebToken-Core' with: [
				spec requires: #( 'NeoJSON' ) ];
			package: 'JSONWebToken-Tests' with: [
				spec requires: #(#'JSONWebToken-Core' ) ] ]
