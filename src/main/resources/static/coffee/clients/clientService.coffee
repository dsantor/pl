class @ClientService

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/client/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @save: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/client/save'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @get: (clientId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/client/id/' + clientId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @update: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/client/update'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)