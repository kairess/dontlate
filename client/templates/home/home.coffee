Template.home.rendered = ->
	instance = @

	@autorun ->
		instance.subscribe "Logs"

Template.home.helpers
	logs: ->
		return Logs.find {}, {sort: {date: -1}, limit: 100}

Template.home.events
	"click #load-csv": (event, template) ->
		file = template.find('#csv-file').files[0]

		Papa.parse file,
			encoding: 'euc-kr'
			header: true
			skipEmptyLines: true
			error: (err, file, inputElem, reason) ->
				console.log err
			complete: (data) ->
				alert '완료'
				Meteor.call 'saveLogs', data.data

	"click #delete-all": (event, template) ->
		Meteor.call 'deleteAllLogs'
