@Todos = new Mongo.Collection('todos')

Todos.attachSchema new SimpleSchema
	name:
		type: String
		label: 'Name'
		#min: 4
		#max: 32
	completed:
		type: Boolean
		label: 'Completed'
	createdAt:
		type: Date
		label: 'Creation Date'
		optional: true
		denyUpdate: true
		autoValue: ->
			if @isInsert
				new Date()
			else
				@unset()
	completedAt:
		type: Date
		label: 'Creation Date'
		optional: true
	createdBy:
		type: String
		label: 'Created by User Id'
		regEx: SimpleSchema.RegEx.Id
	listId:
		type: String
		label: 'List Id'
		regEx: SimpleSchema.RegEx.Id


if Meteor.isServer
	Todos.allow
		insert: (userId, doc) ->
			not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId
		update: (userId, doc, fieldNames, modifier) ->
			not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId
		remove: (userId, doc) ->
			not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId

	Todos.deny
		insert: (userId, doc) ->
			not (not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId)
		update: (userId, doc, fieldNames, modifier) ->
			not (not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId)
		remove: (userId, doc) ->
			not (not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId)
