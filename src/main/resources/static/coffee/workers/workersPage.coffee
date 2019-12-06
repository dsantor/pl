class @WorkersPage extends AbstractPage

    constructor: () ->
        super()
        WorkerService.getAll(null, this, @_workersLoadedSuccess, @_workersLoadedError)
        @createWorkerDialog = new CreateWorkerDialog()
    
    destroy: () ->
        super()
        @createWorkerDialog.destroy()
        @createWorkerDialog = null

    getPageTitle: () ->
        return "Radnici"

    _clickEventHandler: (event) ->
        target = $(event.target)

        if closest(target, '.js--create--worker')
            @createWorkerDialog.show()

        if closest(target, '.js--show--worker')
            id = target.attr('data-worker-id')
            window.location.hash = 'worker/' + id
    
    _workersLoadedSuccess: (response) ->
        @users = response.data
        @pageHTML()

    _customHTML:() ->
        adminOptionsHtml = ""
        if window.loggedUserInfo.isAdmin
            #@_renderSubmenuActions()
            
            adminOptionsHtml = "<nav class='nav justify-content-end pt-3'>
                                    <span class='nav-link span-a js--create--worker'>Dodaj radnika</span>
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
        for u in @users
            if window.loggedUserInfo.isAdmin
                if u.deleted
                    userIcon = 'blocked-user-icon'
                else
                    userIcon = 'user-icon'
                adminOptionsHtml = "<td class='table-text w-10'><span class='#{userIcon} js--show--worker' data-worker-id=#{u.id}></span></td>"
            rowHtml = "<tr class='js--user--row' data-worker-id=#{u.id}>
                        #{ adminOptionsHtml }
				        <td class='table-text w-20'>#{firstName or '/'}</td>
				        <td class='table-text w-20'>#{lastName or '/'}</td>
                        <td class='table-text w-20'>#{phoneNumber or '/'}</td>
                        <td class='table-text w-30'>#{u.email or '/'}</td>
			        </tr>"
            
            tableHtml += rowHtml
        tableHtml += "</table></div>"

        return tableHtml

    _workersLoadedError: (response) ->

    _pageHTML: () ->
        return @emptyState()

    emptyState: () ->
        ComponentsUtils.emptyState('Nema unetih radnika :(', "<input type='button' class='btn btn-primary d-block js--create--worker' value='Dodaj radnika'/>")