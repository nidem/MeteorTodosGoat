$.validator.addMethod 'regex', (value, element, regexp) ->
	re = new RegExp(regexp)
	this.optional(element) || re.test(value)
, 'Please check your input.'

$.validator.setDefaults
	rules:
		username:
			required: true,
			minlength: 4
			maxlength: 32
			required: true
			regex: /^[a-z_][a-z0-9_-]+$/i
		password:
			required: true
			#minlength: 6
	messages:
		username:
			required: 'You must enter an email address.',
			#email: "You've entered an invalid email address."
		password:
			required: 'You must enter a password.',
			minlength: 'Your password must be at least {0} characters.'
