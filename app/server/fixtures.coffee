unless Meteor.users.findOne( username: 'admin' )?
	userId = Accounts.createUser
		username: 'admin'
		password: 'admin'

	Roles.addUsersToRoles userId, 'admin'

# ==== Settings
unless Settings.findOne( key: 'overPublication' )?
	Settings.insert
		key: 'overPublication'
		name: 'Over Publication'
		description: 'Check types when using methods. Must F5 after toggle.'
		value: true

unless Settings.findOne( key: 'verifyCollectionPermissions' )?
	Settings.insert
		key: 'verifyCollectionPermissions'
		name: 'Verify Collection Permissions'
		description: 'Verify user has rights to update collection'
		value: false
