@Logs = new Mongo.Collection "logs"

Logs.helpers
	localDate: ->
		return moment(@date).format('YY-MM-DD')
	localStartTime: ->
		return moment(@startTime).format('HH:mm:ss')
	localEndTime: ->
		return moment(@endTime).format('HH:mm:ss')
	localWorkingTime: ->
		if @workingTime
			return moment.duration(@workingTime).format("h[시간], m[분]")
		return
