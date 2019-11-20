class @UserService

    @loadProfileTemplate: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../templates/userProfile'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @loadCreateUserTemplate: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../templates/createUser'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @loadEditProfileTemplate: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../templates/editProfile'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getUser: (userId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/user/' + userId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @getUsers: (onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/user/all'
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

    @changeUserInfo: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/user/update'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)
    
    @save: (data, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/user/save'
        AjaxRequest.POST(url, data, onTheFlyData, callbackContext, callBackFunction, callbackError)
    

    @remove: (userId, onTheFlyData, callbackContext, callBackFunction, callbackError) ->
        url = '../api/user/remove/' + userId
        AjaxRequest.GET(url, onTheFlyData, callbackContext, callBackFunction, callbackError)

