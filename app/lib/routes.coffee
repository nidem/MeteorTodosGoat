Router.configure
	layoutTemplate: 'MasterLayout'
	loadingTemplate: 'Loading'
	notFoundTemplate: 'NotFound'
	title: 'NetWars Game Server'
	controller: 'DefaultController'

# Require auth & perms for specific routes
# if failed then ask for auth
Router.onBeforeAction ->
	if this.route.options.roles?
		unless Meteor.userId()
			this.render('LoginRequired')
			return
		else
			unless Roles.userIsInRole(Meteor.user(), @route.options.roles)
				this.render('AccessDenied')
				return

	this.next();
	return

Router.plugin 'dataNotFound',
	notFoundTemplate: 'NotFound'
	#	except: ['home', 'logout', 'login', 'register']
	only: []

Router.route '/',
	name: 'home'
	template: 'Home'
	where: 'client'
	title: 'Todos Goat - Home'
	#waitOn: ->
		#Meteor.subscribe 'blah

Router.route '/login',
	name: 'login'
	template: 'Login'
	where: 'client'
	title: 'Todos Goat - Login'

Router.route '/register',
	name: 'register'
	template: 'Register'
	where: 'client'
	title: 'Todos Goat - Register'

Router.route '/lists',
	name: 'lists'
	template: 'Lists'
	where: 'client'
	title: 'Todos Goat - Lists'
	waitOn: ->
		Meteor.subscribe 'lists'

Router.route '/list/:id',
	template: 'ListPage'
	name: 'listPage'
	where: 'client'
	data: ->
		Lists.findOne _id: @params.id
	waitOn: ->
		Meteor.subscribe 'list', @params.id
		Meteor.subscribe 'todos', @params.id

Router.route '/admin/users',
	template: 'AccessDenied',
	name: 'adminUsers'
	where: 'client'
	waitOn: ->
		Meteor.subscribe 'adminUsers'