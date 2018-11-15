Metacello new
    baseline: 'Metacello';
    repository: 'github://metacello/metacello:pharo-6.1_dev/repository';
    onConflict: [ :ex | ex allow ];
    load.

Metacello new 
	repository: 'github://pharo-vcs/tonel';
	baseline: 'Tonel';
	load.
