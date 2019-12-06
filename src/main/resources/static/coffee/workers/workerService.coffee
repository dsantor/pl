class @WorkerService
    @apiUrl = '../api/workers'
    @save: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/save'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)