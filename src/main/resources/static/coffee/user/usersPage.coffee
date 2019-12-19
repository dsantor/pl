class @UserPage extends AbstractPage

    constructor: () ->
        super()
        @pageHTML()
        UserService.getUsers(null, this, @_getUsersSuccess, ajaxCallbackPrintMessage)

        @filterContainer = @container.find('.js--filter--container')
        @usersContainer = @container.find('.js--users--container')

        @autoSuggestion  = new AutoSuggestion(this, @filterContainer, @usersContainer, AutoSuggestion.BASE_FILTER)
        @userASInput = @container.find('.js--filter--as')
        @suggestionsContainer = @container.find('.js--filter--suggestions')
        @userStatus = @container.find('.js--filter--status')        
        @filterToggleButton = @container.find('.js--filters--content')


        @createdNewUser = @_createdNewUser.bind(this)
        EventUtils.bindCreatedNewUser(@createdNewUser)
        @users = []
        @crateUserDialog = new CreateUserDialog()

    destroy: () ->
        super()

        @crateUserDialog.destroy()
        @crateUserDialog = null

        @autoSuggestion.destroy()
        @autoSuggestion = null

        @filterContainer      = null
        @usersContainer       = null        
        @userASInput          = null
        @suggestionsContainer = null
        @userStatus           = null
        @filterToggleButton   = null
        
        EventUtils.unbindCreatedNewUser(@createdNewUser)
        @createdNewUser = null
        @users          = null

    getPageTitle: () ->
        return 'Korisnici'

    _getUsersSuccess: (response) ->
        @users = response.data
        @_renderUsersHTML(@users)

    _renderUsersHTML: (users) ->
        if users is null or users.length is 0
            @emptyState()
            return
        tableHtml = "<div>
                        <table class='table mb-0'>
                            <tr>
                                <th class='table-text w-10'>Profil</th>
                                <th class='table-text w-20'>Ime</th>
                                <th class='table-text w-20'>Prezime</th>
                                <th class='table-text w-20'>Telefon</th>
                                <th class='table-text w-30'>Email</th>
                            </tr>
                        </table>
                        <table class='table table-striped'>"
        rowHtml = ""
        for u in users

            firstName   = u.firstName or '/'
            lastName    = u.lastName or '/'
            phoneNumber = u.phoneNumber or '/'

            if window.loggedUserInfo.isAdmin
                if u.active
                    userIcon = 'user-icon'
                else
                    userIcon = 'blocked-user-icon'
                adminOptionsHtml = "<td class='table-text w-10'><span class='#{userIcon} js--show--user' data-user-id=#{u.id}></span></td>"
            rowHtml = "<tr class='js--user--row' data-user-id=#{u.id}>
                        #{ adminOptionsHtml }
				        <td class='table-text w-20'>#{firstName}</td>
				        <td class='table-text w-20'>#{lastName}</td>
                        <td class='table-text w-20'>#{phoneNumber}</td>
                        <td class='table-text w-30'>#{u.email}</td>
			        </tr>"
            
            tableHtml += rowHtml
        tableHtml += "</table></div>"
        @usersContainer.html(tableHtml)

    _customHTML: () ->
        return "<nav class='nav justify-content-end pt-3'>
                    <span class='nav-link span-a js--create--user'>Dodaj korisnika</span>
                </nav>
                <div class='js--filter--container'></div>
                <div class='js--users--container'>
                    #{ComponentsUtils.loadingPage()}
                </div>"

    emptyState: () ->
        @usersContainer.html(@_emptyState())
    
    _emptyState: () ->
        return "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema registrovanih korisnika :(</div>"

    _showUserInfo: (id) ->
        user = @_getUserById(id)
        
    _clickEventHandler: (e) ->
        targetElement = $(e.target)

        element = targetElement.closest('.js--create--user')
        if element.length > 0
            @crateUserDialog.show()
            return
            
        element = targetElement.closest('.js--show--user')
        if element.length > 0 
            window.location.hash = "user/#{element.attr('data-user-id')}"
            return

        element = targetElement.closest('.js--remove--user')
        if element.length > 0 
            @_removeUser(element)
            return
    
    _removeUser: (element) ->
        userId = element.attr('data-user-id')
        UserService.remove(userId, null, this, @_removeUserSuccess, ajaxCallbackPrintMessage)


    _removeUserSuccess: (response) ->
        userId = response.data
        $(".js--user--row[data-user-id='#{userId}']").remove()
        users = []
        for u in @users
            if u.id isnt userId
                users.push(u)

        @users = users

        if @users.length == 0
            @emptyState()

    _createdNewUser: (event, user) ->
        @users.push(user)
        @_renderUsersHTML(@users)

    _getUserById: (id) ->
        id = +id
        for user in @users
            if user.id is id
                return user
        return null

    userDialogClosed: () ->
        @_renderUsersHTML(@users)



    AutoSuggestionKeyUpEventHander: (event) ->
        target = $(event.target)
        if closest(target, '.js--filter--as')
            ComponentsUtils.handleAutoSuggestion(@userASInput, 'data-user-id', @users, @suggestionsContainer, true, this, @_resetFilter)

    AutoSuggestionChangeEventHander: (event) ->
        @_applyFilter()                   

    AutoSuggestionClickEventHander: (event) ->
        target = $(event.target)

        if closest(target, '.js--filter--suggestions')
            ComponentsUtils.selectFromAutoSuggestion(target, @userASInput, 'data-user-id', @users, @suggestionsContainer)
            @_applyFilter()
            return

        if closest(target, '.js--filter--reset')
            @_resetFilter()
            return

        if closest(target, '.js--filters--button')
            @filterToggleButton.toggleClass('show')
            return

    _applyFilter: () ->
        status = @userStatus.val()
        # @workerASInput.val('') 
        users = []
        if status == 'all'
            users = @users
        else if status == 'active'
            for user in @users
                if not user.deleted
                    users.push(user)
        else
            for user in @users
                if user.deleted
                    users.push(user)

        id = Number(@userASInput.attr('data-user-id'))
        if (! isNaN(id)) 
            filteredUsers = []
            for user in users
                if user.id == id 
                    filteredUsers.push(user)
            users = filteredUsers
                 
        if users.length is 0
            @autoSuggestion.emptyState()
        else
            @_renderUsersHTML(users)

    _resetFilter: () ->
        @userASInput.val('')
        @userASInput.removeAttr('data-user-id')
        @userStatus.val(@userStatus[0].options[0].value)
        @_renderUsersHTML(@users)