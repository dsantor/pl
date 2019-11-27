class @UserDetailsDialog extends AbstractDialog

    constructor: () ->
        super()
        @negativeButtonVisibility(false)
        @positiveButtonText("Zatvori")
        @userId = null
        @user   = null

    show: (@userId) ->
        super()
        UserService.getUser(@userId, null, this, @_getUserSuccess, null)
        # Inputs
        @firstName   = @container.find('.js--first--name')
        @lastName    = @container.find('.js--last--name')
        @street      = @container.find('.js--street')
        @buildNumber = @container.find('.js--build--number')
        @city        = @container.find('.js--city')
        @phoneNumber = @container.find('.js--phone--number')
        @email       = @container.find('.js--email')

    destroy: () ->
        super()
        @firstName      = null
        @lastName       = null
        @street         = null
        @buildNumber    = null
        @city           = null
        @phoneNumber    = null
        @email          = null
        @container.html('')
        @userId = null
        @user = null

    _getUserSuccess: (user) ->
        @firstName.text(user.firstName)
        @lastName.text(user.lastName)
        @phoneNumber.text(user.phoneNumber)
        @email.text(user.email)
        @street.text(user.street)
        @city.text(user.city)
        @buildNumber.text(user.buildNumber)


    _customHTML: () ->
        ComponentsUtils.userDetailsHTML()
    
    positiveAction: () ->
        @hide()
