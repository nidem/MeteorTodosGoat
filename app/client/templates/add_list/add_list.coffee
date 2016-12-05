Template.AddList.events
	'submit form': (event) ->
		event.preventDefault()
		listName = $('[name=listName]').val()
		Meteor.call 'createNewList', listName, (error, result)->
			if error
				console.log error.reason
			else
				Router.go 'listPage', id: result
				$('[name=listName]').val ''

Template.AddList.helpers {}

# AddList: Lifecycle Hooks
Template.AddList.onCreated ->

Template.AddList.onRendered ->

Template.AddList.onDestroyed ->
