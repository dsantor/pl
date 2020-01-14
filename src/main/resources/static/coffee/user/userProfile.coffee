class @UserProfile

    constructor: () ->
        
        @container = $('.js--page--container')
        @container.html(@_html())

        @editProfilePage = new EditProfileDialog()
        @activityDialog  = new ActivityDialog()

        @firstname   = @container.find(".js--firstname")
        @lastname    = @container.find(".js--lastname")
        @phone       = @container.find(".js--phone")
        @email       = @container.find(".js--email")
        @street      = @container.find(".js--street")
        @city        = @container.find(".js--city")
        @buildNumber = @container.find(".js--buildNumber")

        @loggedUser = window.loggedUserInfo
        @_renderUserInfo(@loggedUser)

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent


    getPageTitle: () ->
        return 'Profil'

    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null

        @loggedUser = null
        @editProfilePage.destroy()
        @editProfilePage = null
        @container.html('')

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--edit--profile')
            @editProfilePage.show(this, @loggedUser)
            return
        
        if closest(target, '.js--activity')
            @activityDialog.show(@loggedUser.id)
            return



    _renderUserInfo: (user) ->

        @loggedUser = user
        @firstname.text(user.firstName or '/')
        @lastname.text(user.lastName or '/')
        @phone.text(user.phoneNumber or '/')
        @email.text(user.email or '/')
        @street.text(user.street or '/')
        @city.text(user.city or '/')
        @buildNumber.text(user.buildNumber or '/')

    
    editProfileDialogSuccess: (user) ->
        @loggedUser.firstName   = user.firstName or '/'
        @loggedUser.lastName    = user.lastName or '/'
        @loggedUser.street      = user.street or '/'
        @loggedUser.buildNumber = user.buildNumber or '/'
        @loggedUser.city        = user.city or '/'
        @loggedUser.phoneNumber = user.phoneNumber or '/'
        window.loggedUserInfo = @loggedUser
        @_renderUserInfo(@loggedUser)

    
    _html: () ->
        return "<nav class='nav justify-content-start header pt-3'>
                    <span class='nav-link span-a js--edit--profile'>Izmeni</span>
                    <span class='nav-link span-a js--activity'>Aktivnosti</span>
                </nav>
                
                <div class='h-75 pt-5 flex'>
                    <div class='flex flex-row w-100'>
                        <div class='container w-40'>
                            <div class='profile-image'>
                            </div>
                        </div>
                        <div class='container w-60'>
                            <table class='table table-borderless'>
                                <tr>
                                    <td class='wc-15'>Ime</td>
                                    <td class='js--firstname'></td>
                                </tr>
                                    
                                <tr>
                                    <td class='wc-15'>Prezime</td>
                                    <td class='js--lastname'></td>
                                </tr>
                                    
                                <tr>
                                    <td class='wc-15'>Ulica</td>
                                    <td class='js--street'></td>
                                </tr>
                                
                                <tr>
                                    <td class='wc-15'>Broj stana</td>
                                    <td class='js--buildNumber'></td>
                                </tr>
                                <tr>
                                    <td class='wc-15'>Grad</td>
                                    <td class='js--city'></td>
                                </tr>
                                    
                                <tr>
                                    <td class='wc-15'>Telefon</td>
                                    <td class='js--phone'></td>
                                </tr>
                                    
                                <tr>
                                    <td class='wc-15'>Email</td>
                                    <td class='js--email'></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>"