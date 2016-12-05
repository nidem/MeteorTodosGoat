# accounts settings
Accounts.config
	loginExpirationInDays: 1
	forbidClientAccountCreation: false

# global methods
@isAdmin = (userId) ->
	unless userId
		return false
	Roles.userIsInRole userId, 'admin'

@defaultName = (currentUser) ->
	nextLetter = 'A'
	nextName = 'List ' + nextLetter
	while Lists.findOne(
		name: nextName
		createdBy: currentUser)
		nextLetter = String.fromCharCode(nextLetter.charCodeAt(0) + 1)
		nextName = 'List ' + nextLetter
	nextName
