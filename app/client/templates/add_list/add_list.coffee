Template.AddList.events
	'submit form': (event) ->
		event.preventDefault()
		listName = $('[name=listName]').val()

		listId = Lists.insert
			name: listName
			createdBy: Meteor.userId()
		, (error) ->
			if error
				bootbox.alert error
			else
				$('[name=listName]').val ''
				Router.go 'listPage', id: listId

Template.AddList.helpers {}

# AddList: Lifecycle Hooks
Template.AddList.onCreated ->

Template.AddList.onRendered ->

Template.AddList.onDestroyed ->
