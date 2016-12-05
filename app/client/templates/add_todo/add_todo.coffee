Template.AddTodo.events
	'submit form': (event)->
		event.preventDefault();
		todoName = $('[name="todoName"]').val()

		Todos.insert
			name: todoName
			completed: false
			createdBy: Meteor.userId()
			listId: @_id
		,
		(error) ->
			if error
				bootbox.alert error.message
		$('[name="todoName"]').val ''

Template.AddTodo.helpers {}

# addTodo: Lifecycle Hooks
Template.AddTodo.onCreated ->

Template.AddTodo.onRendered ->

Template.AddTodo.onDestroyed ->
