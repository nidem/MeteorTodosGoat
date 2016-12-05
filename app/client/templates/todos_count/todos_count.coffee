Template.TodosCount.events {}

Template.TodosCount.helpers
	totalTodos: ->
		Todos.find( listId: @_id ).count()

	completedTodos: ->
		Todos.find({ listId: @_id, completed: true }).count()

# todosCount: Lifecycle Hooks
Template.TodosCount.onCreated ->

Template.TodosCount.onRendered ->

Template.TodosCount.onDestroyed ->
