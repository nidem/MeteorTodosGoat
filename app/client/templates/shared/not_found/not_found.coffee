Template.NotFound.events {}

Template.NotFound.helpers {}

# Nav: Lifecycle Hooks
Template.NotFound.onCreated ->

Template.NotFound.onRendered ->
	document.title = '404 Not Found'

Template.NotFound.onDestroyed ->
