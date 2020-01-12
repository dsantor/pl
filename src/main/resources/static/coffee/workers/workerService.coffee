class @WorkerService
    @apiUrl = '../api/workers'
    @save: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/save'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @get: (workerId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/get/' + workerId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @toggleBlockWorker: (workerId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/toggleBlockUser/' + workerId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @update: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/update'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)