initialization
initialize

	super initialize.
	encoder := ZnBase64Encoder new.
	encoder alphabet: URLSafeAlphabet