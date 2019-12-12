class @OrderService

    @apiUrl = '../api/order'
    @create: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/create'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getAll'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @get: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/get/' + data 
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)