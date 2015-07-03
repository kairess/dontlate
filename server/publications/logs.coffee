Meteor.publishComposite 'Logs', ->
	return {
		find: ->
			return Logs.find {}, {sort: {date: -1}, limit: 10000}
		}
