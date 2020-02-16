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
				package: 'JSONWebToken-Tests'
					with: [ spec requires: #(#'JSONWebToken-Core') ];
				package: 'JSONWebToken-OpenSSL'
					with: [ spec requires: #(#'JSONWebToken-Core' 'OpenSSL') ].
			spec
			group: 'Core' with: #('JSONWebToken-Core');
			group: 'SSL' with: #('JSONWebToken-OpenSSL');
                        group: 'Tests' with: #('JSONWebToken-Tests');
			group: 'default' with: #('Core' 'SSL' 'Tests') ]
