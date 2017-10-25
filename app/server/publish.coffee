Meteor.publish 'settings', ->
	Settings.find()

Meteor.publish 'lists', ->
	if Settings.findOne(key: 'overPublication').valueBoolean
		Lists.find()
	else
		Lists.find
			createdBy: @userId

Meteor.publish 'list', (listId)->
	if Settings.findOne(key: 'overPublication').valueBoolean
		check listId, String

	if Meteor.settings.public.overPublication
		Lists.find()
	else
		Lists.find
			#createdBy: @userId
			_id: listId

Meteor.publish 'todos', (listId)->
	if Settings.findOne(key: 'overPublication').value
		check listId, String

	if Meteor.settings.public.overPublication
		Todos.find()
	else
		Todos.find
			createdBy: @userId
			listId: listId

Meteor.publish 'adminUsers', ->
	unless Settings.findOne(key: 'overPublication').value or Roles.userIsInRole @userId, 'admin'
		return @ready()

	Meteor.users.find {},
		fields:
			username: true
			roles: true
