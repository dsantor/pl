class @ExpenseService

    @apiUrl = '../api/expense'
    @create: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/create'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAll: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @get: (expenseId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/get/' + expenseId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getWorkerExpenses: (workerId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getWorkerExpenses/' + workerId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)