Template.home.rendered = ->

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
