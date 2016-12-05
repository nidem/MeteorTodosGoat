Template.Login.events
	'submit .login form': (event) ->
		event.preventDefault()
		return

Template.Login.helpers {}

# login: Lifecycle Hooks
Template.Login.onCreated ->

Template.Login.onRendered ->
	validator = $('.login form').validate
		errorPlacement: (error, element) ->
			error.appendTo(element.parent().parent())
			return
		submitHandler: (event) ->
			username = $('.login').find('[name=username]').val()
			password = $('.login').find('[name=password]').val()
			Meteor.loginWithPassword username, password, (error) ->
				if error
					validator.showErrors
						username: if error.reason == 'error.accounts.Login forbidden' then 'Invalid username or password' else error.reason
				else
					if Router.current().route.getName() == 'login'
						Router.go('home')
				return

			return

	$('.login').find('[name=username]').focus()
	return

Template.Login.onDestroyed ->
