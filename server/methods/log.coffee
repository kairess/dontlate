Meteor.methods
	saveLogs: (data) ->
		for key, value of data
			dateArray = value.date.split '-'
			value.date = new Date(Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], -9, 0, 0))

			startTimeArray = value.start.split ':'
			value.startTime = new Date(Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], parseInt(startTimeArray[0])-9, startTimeArray[1], 0))

			endTimeArray = value.end.split ':'
			value.endTime = new Date(Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], parseInt(endTimeArray[0])-9, endTimeArray[1], 0))

			delete value.rule
			delete value.dep
			delete value.startEvent
			delete value.endEvent
			delete value.start
			delete value.end

			Logs.insert value
