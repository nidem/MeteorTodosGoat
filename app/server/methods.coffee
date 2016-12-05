Meteor.methods
	nukeDatabase: ->
		Lists.remove {}
		Todos.remove {}
		Meteor.users.remove {}

		userId = Accounts.createUser
			username: 'admin'
			password: 'admin'

		Roles.addUsersToRoles userId, 'admin'

###
	createNewList: (listName) ->
		if Meteor.settings.public.useTypeChecks
			check listName, String

		userId = Meteor.userId()
		unless userId
			throw new Meteor.Error 'not-logged-in', 'You\'re not logged-in.'

		if listName.trim() == ''
			listName = defaultName userId

		Lists.insert
			name: listName
			createdBy: userId

	createListItem: (todoName, listId) ->
		if Meteor.settings.public.useTypeChecks
			check todoName, String
			check listId, String

		userId = Meteor.userId()
		unless userId
			throw new Meteor.Error 'not-logged-in', 'You\'re not logged-in.'

		currentList = Lists.findOne _id: listId
		if currentList.createdBy != userId
			throw new Meteor.Error 'invalid-user', 'You don\'t own that list.'

		Todos.insert
			name: todoName
			completed: false
			createAt: new Date
			createdBy: userId
			listId: currentList

	updateListItem: (documentId, todoItem) ->
		if Meteor.settings.public.useTypeChecks
			check todoItem, String

		userId = Meteor.userId()
		unless userId
			throw new Meteor.Error 'not-logged-in', 'You\'re not logged-in.'

		Todos.update
			_id: documentId
			createdBy: userId
		,
			$set: name: todoItem

		return

	changeItemStatus: (id, status) ->
		if Meteor.settings.public.useTypeChecks
			check status, Boolean

		userId = Meteor.userId()
		unless userId
			throw new Meteor.Error 'not-logged-in', 'You are not logged-in.'

		Todos.update
			_id: id
			createdBy: userId
		,
			$set: completed: status
		return

	removeListItem: (id) ->
		if Meteor.settings.public.useTypeChecks
			check id, String

		userId = Meteor.userId()
		unless userId
			throw new Meteor.Error 'not-logged-in', 'You\'re not logged-in.'

		Todos.remove
			_id: id
			createdBy: userId
		return
###