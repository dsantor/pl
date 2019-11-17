class @UserService

    @loadProfileTemplate: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/templates/userProfile'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @loadCreateUserTemplate: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/templates/createUser'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @loadEditProfileTemplate: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/templates/editProfile'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getUser: (userId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/user/' + userId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getUsers: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/user/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @changeUserInfo: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/user/update'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @save: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/user/save'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)
    

    @remove: (userId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '/user/remove/' + userId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

