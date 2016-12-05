Template.Register.events {}

Template.Register.helpers {}

# register: Lifecycle Hooks
Template.Register.onCreated ->

Template.Register.onRendered ->
	validator = $('.register form').validate
		errorPlacement: (error, element) ->
			error.appendTo(element.parent().parent())
			return
		submitHandler: (event) ->
			username = $('.register').find('[name=username]').val()
			password = $('.register').find('[name=password]').val()
			Meteor.call 'createUser',
					username: username
					password: password
			, (error) ->
				if error
					if error.reason == 'Username already exists.'
						validator.showErrors email: 'That email already belongs to a registered user.'
					else
						validator.showErrors error.reason
				else
					Router.go 'home'

	$('.register').find('[name=username]').focus()
	return

Template.Register.onDestroyed ->
