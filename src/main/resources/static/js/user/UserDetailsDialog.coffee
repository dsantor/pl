class @UserDetailsDialog

    constructor: () ->
        @container = $('.js--side--dialog--container')
        UserService.loadProfileTemplate(null, this, @_loadProfileTemplateSucess, null)

        @userId = null
        @user   = null

    show: (@userId) ->
        @container.attr('visibility', true)
        UserService.getUser(@userId, null, this, @_getUserSuccess, null)

    destroy: () ->
        @container.html('')
        @container = null
        @userId = null
        @user = null

    _loadProfileTemplateSucess:(template) ->
        @container.html(template)
        @firstname   = @container.find(".js--firstname")
        @lastname    = @container.find(".js--lastname")
        @phone       = @container.find(".js--phone")
        @email       = @container.find(".js--email")
        @street      = @container.find(".js--street")
        @city        = @container.find(".js--city")
        @buildNumber = @container.find(".js--buildNumber")


    _getUserSuccess: (user) ->
        @firstname.text(user.firstName)
        @lastname.text(user.lastName)
        @phone.text(user.phoneNumber)
        @email.text(user.email)
        @street.text(user.street)
        @city.text(user.city)
        @buildNumber.text(user.buildNumber)