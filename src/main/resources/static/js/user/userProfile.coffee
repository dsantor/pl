class @UserProfile

    constructor: () ->
        @container = $('.js--page--container')

        @loggedUser = null
        @editProfilePage = new EditProfileDialog()

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        UserService.loadProfileTemplate(null, this, @_loadProfileTemplateSucess, null)

    getPageTitle: () ->
        return 'Profile'

    
    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null

        @loggedUser = null
        @editProfilePage.destroy()
        @editProfilePage = null
        @container.html('')

    _clickEventHandler: (event) ->
        target = $(event.target)

        element = target.closest('.js--edit--profile')
        if element.length != 0
            @editProfilePage.show(this, @loggedUser)
            return

    _loadProfileTemplateSucess: (template) ->
        @container.html(template)
        @firstname   = @container.find(".js--firstname")
        @lastname    = @container.find(".js--lastname")
        @phone       = @container.find(".js--phone")
        @email       = @container.find(".js--email")
        @street      = @container.find(".js--street")
        @city        = @container.find(".js--city")
        @buildNumber = @container.find(".js--buildNumber")

        UserService.getUser(window.loggedUserId, null, this, @_getUserSuccess, null)
    

    _getUserSuccess: (user) ->
        window.loggedUser = user
        @loggedUser = user
        @firstname.text(user.firstName)
        @lastname.text(user.lastName)
        @phone.text(user.phoneNumber)
        @email.text(user.email)
        @street.text(user.street)
        @city.text(user.city)
        @buildNumber.text(user.buildNumber)

    
    editProfileDialogSuccess: (user) ->
        @loggedUser = user
        @_getUserSuccess(@loggedUser)