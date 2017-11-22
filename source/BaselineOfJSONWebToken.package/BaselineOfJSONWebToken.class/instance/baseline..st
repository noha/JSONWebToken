baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: '13';
					repository: 'http://mc.stfx.eu/Neo' ].
		spec 
			package: #'JSONWebToken-Core';
			package: 'JSONWebToken-Tests' with: [
				spec requires: #(#'JSONWebToken-Core' ). ]. ].
