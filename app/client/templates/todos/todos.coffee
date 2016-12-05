Template.Todos.events {}

Template.Todos.helpers
	todo: ->
		Todos.find
			listId: @_id,
			#createdBy: Meteor.userId()
		,
			sort:
				createdAt: -1
				_id: 1

# todos: Lifecycle Hooks
Template.Todos.onCreated ->

Template.Todos.onRendered ->

Template.Todos.onDestroyed ->
