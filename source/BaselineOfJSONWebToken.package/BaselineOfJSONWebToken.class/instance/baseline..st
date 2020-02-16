baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'NeoJSON'
				with: [ spec repository: 'github://svenvc/NeoJSON:master/repository' ].
			spec
				baseline: 'OpenSSL'
				with: [ spec repository: 'github://PierceNg/OpenSSL-Pharo/src-st' ].
			spec
				package: #'JSONWebToken-Core'
					with: [ spec requires: #('NeoJSON') ];
				package: 'JSONWebToken-Core-Tests'
					with: [ spec requires: #(#'JSONWebToken-Core') ];
				package: 'JSONWebToken-OpenSSL'
					with: [ spec requires: #(#'JSONWebToken-Core' 'OpenSSL') ];
				package: 'JSONWebToken-OpenSSL-Tests'
					with: [ spec requires: #(#'JSONWebToken-OpenSSL') ].
			spec
			group: 'Core' with: #('JSONWebToken-Core');
			group: 'SSL' with: #('JSONWebToken-OpenSSL');
			group: 'Tests' with: #('JSONWebToken-Core-Tests' 'JSONWebToken-OpenSSL-Tests');
			group: 'default' with: #('Core' 'SSL' 'Tests') ]
