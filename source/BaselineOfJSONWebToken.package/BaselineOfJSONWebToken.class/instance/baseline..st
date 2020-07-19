baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'NeoJSON'
				with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ].
			spec
				package: 'JSONWebToken-Core'
					with: [ spec requires: #('NeoJSON') ];
				package: 'JSONWebToken-Core-Tests'
					with: [ spec requires: #('JSONWebToken-Core') ].
			spec group: 'Core' with: #('JSONWebToken-Core') ].
	spec
		for: #pharo
		do: [ spec
				baseline: 'OpenSSL'
				with: [ spec repository: 'github://PierceNg/OpenSSL-Pharo/src-st' ].
			spec
				package: 'JSONWebToken-OpenSSL'
					with: [ spec requires: #('JSONWebToken-Core' 'OpenSSL') ];
				package: 'JSONWebToken-OpenSSL-Tests'
					with: [ spec requires: #(#'JSONWebToken-OpenSSL') ].
			spec
				group: 'SSL' with: #('JSONWebToken-OpenSSL');
				group: 'Tests'
					with: #('JSONWebToken-Core-Tests' 'JSONWebToken-OpenSSL-Tests');
				group: 'default' with: #('Core' 'SSL' 'Tests') ].
	spec
		for: #gemstone
		do: [ spec
				baseline: 'NeoJSON'
				with: [ spec repository: 'github://gsdevkit/NeoJSON:master/repository' ].
			spec
				group: 'default' with: #('Core');
				group: 'Tests' with: #('JSONWebToken-Core-Tests') ]