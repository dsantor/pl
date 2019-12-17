class @ExpenseService

    @apiUrl = '../api/expense'
    @create: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/create'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getAll'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @get: (orderId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/get/' + orderId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)