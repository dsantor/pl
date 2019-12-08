class @OrderService

    @apiUrl = '../api/order'
    @create: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/create'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)