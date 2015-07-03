Meteor.methods
	saveLogs: (data) ->
		existLog = Logs.findOne {
			date: moment(data[0]["날짜"]).toDate()
			name: data[0]["이름"]
		}

		if existLog
			return throw new Meteor.Error 501, "Already exist!"

		for key, value of data
			value.date = value['날짜']
			value.userId = value['ID']
			value.name = value['이름']
			value.dailyRule = value['일일규칙']
			value.start = value['출근']
			value.end = value['퇴근']
			value.result = value['결과']

			delete value['부서']
			delete value['근무규칙']
			delete value['출근이벤트']
			delete value['퇴근이벤트']
			delete value['기본근무']
			delete value['휴식시간']
			delete value['근무시간']
			delete value['날짜']
			delete value['ID']
			delete value['이름']
			delete value['일일규칙']
			delete value['출근']
			delete value['퇴근']
			delete value['결과']

			dateArray = value.date.split '-'

			value.date = moment(value.date).toDate()

			startTimeArray = value.start.split ':'
			value.startTime = new Date(Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], parseInt(startTimeArray[0])-9, startTimeArray[1], 0))

			endTimeArray = value.end.split ':'
			value.endTime = new Date(Date.UTC(dateArray[0], dateArray[1]-1, dateArray[2], parseInt(endTimeArray[0])-9, endTimeArray[1], 0))

			if value.result is '지각' or value.result is '정상근무' or value.result is '비번일'
				value.workingTime = value.endTime - value.startTime

			delete start
			delete end

			Logs.insert value

	deleteAllLogs: ->
		Logs.remove({})
