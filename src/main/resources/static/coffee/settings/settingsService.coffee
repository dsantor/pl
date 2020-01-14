class @SettingsService

    @apiUrl = '../api/settings'

    @saveOrderTypes: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/saveOrderTypes'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @getDoorSettings: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getDoorSettings'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getAllOrderTypes: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = @apiUrl + '/getAllOrderTypes'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)