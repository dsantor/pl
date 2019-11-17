class @ClientService

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/client/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)


    @save: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/client/save'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getClient: (clientId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/client/id/' + clientId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)