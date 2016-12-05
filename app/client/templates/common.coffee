Number::toRoman = ->
	num = Math.floor(this)
	return '0' if num == 0

	val = undefined
	s = ''
	i = 0
	v = [
		1000
		900
		500
		400
		100
		90
		50
		40
		10
		9
		5
		4
		1
	]
	r = [
		'M'
		'CM'
		'D'
		'CD'
		'C'
		'XC'
		'L'
		'XL'
		'X'
		'IX'
		'V'
		'IV'
		'I'
	]

	toBigRoman = (n) ->
		`var s`
		`var n`
		ret = ''
		n1 = ''
		rem = n
		while rem > 1000
			prefix = ''
			suffix = ''
			n = rem
			s = '' + rem
			magnitude = 1
			while n > 1000
				n /= 1000
				magnitude *= 1000
				prefix += '('
				suffix += ')'
			n1 = Math.floor(n)
			rem = s - (n1 * magnitude)
			ret += prefix + n1.toRoman() + suffix
		ret + rem.toRoman()

	if this - num or num < 1
		num = 0
	if num > 3999
		return toBigRoman(num)
	while num
		val = v[i]
		while num >= val
			num -= val
			s += r[i]
		++i
	s

Number::pad = (size, padding = '0') ->
	s = String(this)
	if size > s.length
		new Array(size - s.length + 1).join(padding) + s
	else
		s

String::pad = (size, padding = ' ') ->
	s = String(this)
	if size > s.length
		new Array(size - s.length + 1).join(padding) + s
	else
		s

Array::unique = ->
	output = {}
	output[@[key]] = @[key] for key in [0...@length]
	value for key, value of output

Template.registerHelper 'timeAgo', (datetime) ->
	Session.get 'time'
	if datetime?
		moment(datetime).fromNow()
	else
		''

Template.registerHelper 'unsafeText', (s)->
	new Spacebars.SafeString s

Template.registerHelper 'markDownText', (s)->
	Blaze._globalHelpers.unsafeMarkDownText s.replace(/</g, '&lt;').replace(/>/g, '&gt;')

Template.registerHelper 'unsafeMarkDownText', (s)->
	s2 = parseMarkdown s.replace /(?:\r\n|\r|\n)+/g, '\n\n'
	# add the prompt
	s3 = s2.replace /(\\)?\^(.*?)\^/gm, (wholeMatch, leadingSlash, prompt) ->
		if leadingSlash
			return wholeMatch
		else
			return '<prompt>' + prompt + '</prompt>'
	# preserve ^ if prefixed with a \
	s4 = s3.replace '\\^', '^'

	new Spacebars.SafeString s4

Template.registerHelper 'timeDiff', (datetime) ->
	diff = (new Date()) - datetime
	result = ''
	if diff > 3600
		result = Math.floor(diff / 3600) + ':'
	if diff > 60
		result += Math.floor((diff % 3600) / 60) + ':'
	diff += diff % 60

Template.registerHelper 'formatTime', (time) ->
	if time
		moment(time).format('L HH:mm')
	else
		null

Template.registerHelper '_', ->
	_

Template.registerHelper 'plural', (a) ->
	if a == 1
		''
	else
		's'

Template.registerHelper 'ternary', (val, a, b) ->
	if !!val then a else b

Template.registerHelper 'and', (a, b) ->
	a and b

Template.registerHelper 'or', (a, b) ->
	a or b

Template.registerHelper 'add', (a, b) ->
	a + b

Template.registerHelper 'getScorers', (options)->
	filter = if options instanceof Spacebars.kw then options.hash else (options or {})
	filter.hidden = false
	Scorers.find filter