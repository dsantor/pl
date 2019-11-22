class @UserActionLogService

    @apiUrl = '/api/userActivityLog'

    @getUserActivityLogForUser: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getUserActivityLogForUser/' + data
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)