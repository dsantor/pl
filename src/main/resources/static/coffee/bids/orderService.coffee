class @OrderService

    @apiUrl = '../api/order'
    @create: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/create'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getAll'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @get: (orderId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/get/' + orderId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAllClientOrders: (clientId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getAll/' + clientId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)