class @UserDetailsDialog extends AbstractPage

    constructor: (userId) ->
        super()
        UserService.getUser(userId, null, this, @show, null)

        @activityDialog = new ActivityDialog()

    show: (respone) ->
        @user = respone.data
        @pageHTML()
        
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
            html = "<nav class='nav justify-content-end header pt-3'>
                        <span class='nav-link span-a back-button js--back--button'>Nazad</span>
                        <span class='nav-link span-a js--reset--password'>Restartuj šifru</span>
                        <span class='nav-link span-a js--block--user'>#{innerHTML}</span>
                        <span class='nav-link span-a js--user--activity'>Aktivnosti</span>
                    </nav>"
            html += ComponentsUtils.userDetailsFilledHTML(@user)
            return html
        else
            ComponentsUtils.emptyState('Korisnik nije pronadjen :(')
    
    positiveAction: () ->
        @hide()

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--back--button')
            window.history.back()
            # window.location.hash = 'users'
            return
        
        if closest(target, '.js--reset--password')
            @_resetPassword()
            return
        
        if closest(target, '.js--block--user')
            @_toggleBlockUser()
        
        if closest(target, '.js--user--activity')
            @activityDialog.show(@user.id)
            return
            
    _resetPassword: () ->
        UserService.defaultPassword(@user.id, null, this, @_globalSuccessMessage, @_globalErrorMessage)

    _globalSuccessMessage: (response) ->
        FloatingMessage.success(response.message)
    _globalErrorMessage: (response) ->
        FloatingMessage.error(response.message)

    _toggleBlockUserText: () ->
        text = 'Aktiviraj'
        if @user.active
            text = 'Deaktiviraj'
        return text

    _toggleBlockUser: () ->
        @user.active = !@user.active
        @updatedUser = true
        $(".js--block--user").html(@_toggleBlockUserText())
        UserService.toggleBlockUser(@user.id, null, this, @_globalSuccessMessage, @_globalErrorMessage)