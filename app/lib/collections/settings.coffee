@Settings = new Mongo.Collection('settings')

Settings.attachSchema new SimpleSchema
	key:
		type: String
		label: 'Key'
		denyUpdate: true
		unique: true
	name:
		type: String
		label: 'Name'
		denyUpdate: true
		unique: true
	description:
		type: String
		label: 'Description'
		denyUpdate: true
	value:
		type: Boolean
		label: 'Boolean Value'

if Meteor.isServer
  Settings.allow
    insert: (userId, doc) ->
	    false
    update: (userId, doc, fieldNames, modifier) ->
      true
    remove: (userId, doc) ->
      false

  Settings.deny
    insert: (userId, doc) ->
      true
    update: (userId, doc, fieldNames, modifier) ->
      false
    remove: (userId, doc) ->
      true
