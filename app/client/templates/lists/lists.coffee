Template.Lists.events {}

Template.Lists.helpers
	list: ->
		Lists.find createdBy: Meteor.userId(),
			sort: name: 1

# Lists: Lifecycle Hooks
Template.Lists.onCreated ->

Template.Lists.onRendered ->

Template.Lists.onDestroyed ->
