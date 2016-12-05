@Lists = new Mongo.Collection('lists')

Lists.attachSchema new SimpleSchema
	name:
		type: String
		label: 'Name'
		min: 4
		max: 32
	createdBy:
		type: String
		label: 'Created by User Id'
		regEx: SimpleSchema.RegEx.Id

if Meteor.isServer
	Lists.allow
		insert: (userId, doc) ->
			not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId
		update: (userId, doc, fieldNames, modifier) ->
			not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId
		remove: (userId, doc) ->
			not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId

	Lists.deny
		insert: (userId, doc) ->
			not (not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId)
		update: (userId, doc, fieldNames, modifier) ->
			not (not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId)
		remove: (userId, doc) ->
			not (not Meteor.settings.public.verifyCollectionPermissions or userId == doc.createdBy or @isAdmin userId)
