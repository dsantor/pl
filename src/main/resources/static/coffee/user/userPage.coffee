class @UserPage extends AbstractPage

    constructor: (userId) ->
        super()
        @activityDialog = new ActivityDialog()

        if  `window.loggedUserInfo.id == userId`
            window.location.hash = '#profile'
        else
            UserService.getUser(userId, null, this, @show, null)

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

        @activityDialog.destroy()
        @activityDialog = null

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
            MainNavigation.back()
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
        UserService.defaultPassword(@user.id, null, this, globalSuccessMessage, globalErrorMessage)

    _toggleBlockUserText: () ->
        text = 'Aktiviraj'
        if @user.active
            text = 'Deaktiviraj'
        return text

    _toggleBlockUser: () ->
        @user.active = !@user.active
        @updatedUser = true
        $(".js--block--user").html(@_toggleBlockUserText())
        UserService.toggleBlockUser(@user.id, null, this, globalSuccessMessage, globalErrorMessage)