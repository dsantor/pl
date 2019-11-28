class @UserDetailsDialog extends AbstractDialog

    constructor: () ->
        super()
        @negativeButtonVisibility(false)
        @positiveButtonText("Zatvori")
        @user       = null
        @updatedUser = false
    show: (@parentPage, @user) ->
        super()
       
        if @user isnt null
            # Inputs
            @firstName   = @container.find('.js--first--name')
            @lastName    = @container.find('.js--last--name')
            @street      = @container.find('.js--street')
            @buildNumber = @container.find('.js--build--number')
            @city        = @container.find('.js--city')
            @phoneNumber = @container.find('.js--phone--number')
            @email       = @container.find('.js--email')

            @firstName.text(@user.firstName)
            @lastName.text(@user.lastName)
            @phoneNumber.text(@user.phoneNumber)
            @email.text(@user.email)
            @street.text(@user.street)
            @city.text(@user.city)
            @buildNumber.text(@user.buildNumber)

    hide: () ->
        super()
        if @updatedUser
            @parentPage.userDialogClosed()

    destroy: () ->
        super()
        @firstName      = null
        @lastName       = null
        @street         = null
        @buildNumber    = null
        @city           = null
        @phoneNumber    = null
        @email          = null
        @user           = null
        @parentPage     = null
        @updatedUser    = null

    _customHTML: () ->
        if @user
            innerHTML = @_toggleBlockUserText()
            html = "<nav class='nav justify-content-start header pt-3'>
                        <span class='nav-link span-a js--reset--password'>Restartuj šifru</span>
                        <span class='nav-link span-a js--block--user'>#{innerHTML}</span>
                        <span class='nav-link span-a js--user--activity'>Aktivnosti</span>
                    </nav>"
            html += ComponentsUtils.userDetailsHTML()
            return html
        else
            ComponentsUtils.emptyState('Korisnik nije pronadjen :(')
    
    positiveAction: () ->
        @hide()

    _pageClientEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--reset--password')
            @_resetPassword()
            return
        if closest(target, '.js--block--user')
            @_toggleBlockUser()

    _resetPassword: () ->
        UserService.defaultPassword(@user.id, null, this, @_globalSuccessMessage, @_globalErrorMessage)

    _globalSuccessMessage: (response) ->
        FloatingMessage.success(response.message)
    _globalErrorMessage: (response) ->
        FloatingMessage.error(response.message)

    _toggleBlockUserText: () ->
        text = 'Odblokiraj'
        if @user.active
            text = 'Blokiraj'
        return text

    _toggleBlockUser: () ->
        @user.active = !@user.active
        @updatedUser = true
        $(".js--block--user").html(@_toggleBlockUserText())
        UserService.toggleBlockUser(@user.id, null, this, @_globalSuccessMessage, @_globalErrorMessage)