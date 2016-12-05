Template.TodoItem.events
	'click .delete-todo': (event) ->
		event.preventDefault()

		id = @_id
		bootbox.confirm 'Delete task "' + @name + '"?', (result) ->
			if result
				#Meteor.call 'removeListItem', id
				Todos.remove _id: id

	'keyup [name=todoItem]': (event) ->
		if event.which == 13 or event.which == 27
			$(event.target).blur()
		else
			Todos.update _id: @_id,
				$set: name: $(event.target).val().trim()

	'change [type=checkbox]': ->
		#Meteor.call 'changeItemStatus', @_id, not @completed
		if @completed
			Todos.update _id: @_id,
				$set:
					completed: false
				$unset:
					completedAt: ''
		else
			Todos.update _id: @_id,
				$set:
					completed: true
					completedAt: new Date()

Template.TodoItem.helpers

# todoItem: Lifecycle Hooks
Template.TodoItem.onCreated ->

Template.TodoItem.onRendered ->

Template.TodoItem.onDestroyed ->
