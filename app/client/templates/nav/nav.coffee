Template.Nav.events
	'click .logout': (event) ->
		event.preventDefault()
		Meteor.logout()
		Router.go 'login'

	'click .nuke-databse': (event) ->
		event.preventDefault()
		bootbox.confirm 'Delete all todo lists and users from the database?', (result)->
			if result
				Meteor.call 'nukeDatabase'

Template.Nav.helpers
	navSettings: ->
		Settings.find()

# nav: Lifecycle Hooks
Template.Nav.onCreated ->

Template.Nav.onRendered ->

Template.Nav.onDestroyed ->
