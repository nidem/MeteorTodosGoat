Template.NavSetting.events
	'click .nav-setting': (event) ->
		event.preventDefault()
		event.stopPropagation()

		# toggle
		Settings.update _id: @_id,
			$set: value: not @value

Template.NavSetting.helpers

# NavSettings: Lifecycle Hooks
Template.NavSetting.onCreated ->

Template.NavSetting.onRendered ->

Template.NavSetting.onDestroyed ->
