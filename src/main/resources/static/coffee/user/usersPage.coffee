class @UserPage #extends @AbstractPage

    constructor: () ->
        @container = $('.js--page--container')

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent


        UserService.getUsers(null, this, @_getUsersSuccess, @_getUsersError)

        @createdNewUser = @_createdNewUser.bind(this)
        EventUtils.bindCreatedNewUser(@createdNewUser)

        @users = []
    
        @userDetailsDialog = new UserDetailsDialog()
        @crateUserDialog = new CreateUserDialog()

    getPageTitle: () ->
        return 'Users'

    _getUsersSuccess: (response) ->
        @users = response.data
        if @users is null or @users.length is 0
            @_renderEmptyState()
        else
            @_renderUsers(@users)

    _getUsersError: (response) ->
        console.log response.message

    _renderUsers: (users) ->
        adminOptionsHtml = ""
        if window.loggedUserInfo.isAdmin
            #@_renderSubmenuActions()
            
            adminOptionsHtml = "<nav class='nav justify-content-end pt-3'>
                                    <span class='nav-link span-a js--create--user'>Dodaj korisnika</span>
                                </nav>
                    <th class='table-text w-10'>Profil</th>"
 
        tableHtml = "<div>
                        <table class='table mb-0'>
                            <tr>
                                #{ adminOptionsHtml }
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

        @container.html(tableHtml)


    _renderEmptyState: () ->
        html = "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema registrovanih korisnika :(</div>
        <div class='pt-3'><input type='button' class='btn btn-primary d-block js--create--user' value='Dodaj korisnika'/>
		</div>"
        @container.html(html)

    _showUserInfo: (id) ->
        user = @_getUserById(id)
    show: () ->	

    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null

        @userDetailsDialog.destroy()
        @userDetailsDialog = null
        
        @crateUserDialog.destroy()
        @crateUserDialog  = null
        
        EventUtils.unbindCreatedNewUser(@createdNewUser)
        @createdNewUser = null

        @container.html('')
        @users = null


    _renderSubmenuActions: () ->
        if window.loggedUserInfo.isAdmin
            html = "<nav class='nav justify-content-end pt-5 pb-3'>
                        <a href='#create-user' class='nav-item nav-link active'>Dodaj korisnika</a>
                    </nav>"
            @container.append(html)


    _clickEventHandler: (e) ->
        targetElement = $(e.target)

        element = targetElement.closest('.js--create--user')
        if element.length > 0
            @crateUserDialog.show()
            return
        
        
        element = targetElement.closest('.js--show--user')
        if element.length > 0 
            user = @_getUserById(element.attr('data-user-id'))
            @userDetailsDialog.show(this, user)
            return
        # Move to edit dialog
        element = targetElement.closest('.js--remove--user')
        if element.length > 0 
            @_removeUser(element)
            return


    
    _removeUser: (element) ->
        userId = element.attr('data-user-id')
        UserService.remove(userId, null, this, @_removeUserSuccess, @_removeUserError)


    _removeUserSuccess: (response) ->
        userId = response.data
        $(".js--user--row[data-user-id='#{userId}']").remove()
        users = []
        for u in @users
            if u.id isnt userId
                users.push(u)

        @users = users

        if @users.length == 0
            @_renderEmptyState()

    _removeUserError: (response) ->
        console.error response

    _createdNewUser: (event, user) ->
        @users.push(user)
        @_renderUsers(@users)

    _getUserById: (id) ->
        id = +id
        for user in @users
            if user.id is id
                return user
        return null

    userDialogClosed: () ->
        @_renderUsers(@users)