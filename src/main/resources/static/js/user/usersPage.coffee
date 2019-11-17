class @UserPage
    constructor: () ->
        @container = $('.js--page--container')
        UserService.loadUsersTemplate(null, this, @_loadUsersTemplateSucess, null)

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent

        @users = []

        @userDetailsDialog = new UserDetailsDialog();

    getPageTitle: () ->
        return 'Users'

    _loadUsersTemplateSucess: (template) ->
        #@container.append (template)
        UserService.getUsers(null, this, @_getUsersSuccess, @_getUsersError)

    _getUsersSuccess: (data) ->
        if data is null or data.length is 0
            @_renderEmptyState()
        else
            @users = data
            @_renderUsers(data)

    _getUsersError: (error) ->
        console.log error

    _renderUsers: (users) ->
        adminOptionsHtml = ""
        if window.isAdmin
            #@_renderSubmenuActions()
            
            adminOptionsHtml = "<nav class='nav justify-content-end pt-5 pb-3'>
                                    <a href='#create-user' class='nav-item nav-link active'>Dodaj korisnika</a>
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

            if window.isAdmin
                adminOptionsHtml = "<td class='table-text w-10'><span class='profile-icon js--show--user' data-user-id=#{u.id}></span></td>"
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

    show: () ->	

    destroy: () ->
        @container.off 'click', @_clickEventHandler
        @clickEvent = null
        @container.html('')

        @users = null


    _renderSubmenuActions: () ->
        if window.isAdmin
            html = "<nav class='nav justify-content-end pt-5 pb-3'>
                        <a href='#create-user' class='nav-item nav-link active'>Dodaj korisnika</a>
                    </nav>"
            @container.append(html)


    _clickEventHandler: (e) ->
        targetElement = $(e.target)

        element = targetElement.closest('.js--create--user')
        if element.length > 0
            window.location.hash = 'create-user'
            return
        
        
        element = targetElement.closest('.js--show--user')
        if element.length > 0 
            @userDetailsDialog.show(element.attr('data-user-id'))
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
