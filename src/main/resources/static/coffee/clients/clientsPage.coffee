class @ClientsPage extends AbstractPage

    constructor: () ->
        super()
        @pageHTML()
        ClientService.getAll(null, this, @_renderClients, @_renderClientsError)

        @filterContainer  = @container.find('.js--filter--container--wrapper')
        @clientsContainer = @container.find('.js--clients--container')
        filterStatus = [{key: 'all', value: 'Svi'}, {key: 'paid', value: 'Plaćeno'}, {key: 'unpaid', value: 'Neplaćeno'}]
        @autoSuggestion = new AutoSuggestion(this, @filterContainer, AutoSuggestion.BASE_FILTER, filterStatus)
        @filterAsInput = @container.find('.js--filter--as')
        @suggestionsContainer = @container.find('.js--filter--suggestions')
        @filterStatus = @container.find('.js--filter--status')        

        @createdNewClient = @_createdNewClient.bind(this)
        EventUtils.bindCreatedNewClient(@createdNewClient)
        @createClientDialog = new CreateClientDialog()

        @clients = []
    
    destroy: () ->
        EventUtils.unbindCreatedNewClient(@createdNewClient)
        @createdNewClient = null

        @createClientDialog.destroy()
        @createClientDialog = null

        @clients = null
        @container.html('')
        

    getPageTitle: () ->
        return "Klijenti"

    _renderClients: (response) ->
        @clients = response.data
        if @clients and @clients.length > 0
            @_renderClientsHTML(@clients)
        else
            @_renderEmptyState()

    _renderClientsError: (response) ->
        console.log response

    _renderEmptyState: () ->
        html = "<div class='col-5 m-auto h-75 pt-5 text-center'>Nema registrovanih klijenata :(</div>
        <div class='pt-3'><input type='button' class='btn btn-primary d-block js--create--client' value='Dodaj klijenta'/>
		</div>"
        @clientsContainer.html(html)

    _customHTML: () ->
        return " <nav class='nav justify-content-end pt-3'>
                    <span class='nav-link span-a js--create--client'>Dodaj klijenta</span>
                </nav>
                <div class='js--filter--container--wrapper'></div>
                <div class='js--clients--container'>
                    #{ComponentsUtils.loadingPage()}
                </div>"

    _renderClientsHTML: (clients) ->        
        tableHtml = "
                    <div>
                <table class='table mb-0'>
                    <tr>
                        <th class='table-text w-10'>Profil</th>
                        <th class='table-text w-15'>Ime</th>
                        <th class='table-text w-20'>Prezime</th>
                        <th class='table-text w-15'>Telefon</th>
                        <th class='table-text w-20'>Ulica</th>
                        <th class='table-text w-20'>Email</th>
                    </tr>
                </table>
                <table class='table table-striped'>"
        rowHtml = ""
        for client in clients
            firstName    = client.firstName or '/'
            lastName     = client.lastName or '/'
            phoneNumber  = client.phoneNumber or '/'
            mobileNumber = client.mobileNumber or '/'
            street       = client.street or '/'
            email        = client.email or '/'

            rowHtml = "<tr class='js--client--row' data-client-id=#{client.id}>
                        <td class='table-text w-10'>
                            <a href='#client/#{client.id}'><span class='client-details-icon'></span></a>
                        </td>
				        <td class='table-text w-15'>#{firstName}</td>
				        <td class='table-text w-20'>#{lastName}</td>
                        <td class='table-text w-15'>#{phoneNumber}</td>
                        <td class='table-text w-20'>#{street}</td>
                        <td class='table-text w-20'>#{email}</td>
			        </tr>"
            
            tableHtml += rowHtml
        tableHtml += "</table></div>"

        @clientsContainer.html(tableHtml)

    _clickEventHandler: (event) ->

        target = $(event.target)

        if @_closest(target, ".js--create--client")
            @createClientDialog.show()
            return

        if @_closest(target, '.js--show--client')
            id = target.attr('data-client-id')
            window.location.hash = 'client/' + id
            return


    _closest: (target, closestTo) ->
        return target.closest(closestTo).length > 0

    _refreshClientsHTML: () ->
        @_renderClientsHTML(@clients)

    _addNewClient: (client) ->
        @clients.push(client)

    _createdNewClient: (event, client) ->
        @_addNewClient(client)
        @_refreshClientsHTML()



    # Auto suggestions
    triggerFilterAs: (event) ->
        ComponentsUtils.handleAutoSuggestion(@filterAsInput, 'data-client-id', @clients, @suggestionsContainer, true, this, @_resetFilter)

    triggerFilterStatus: (event) ->
        @_applyFilter()                   

    triggerFilterSuggestions: (event) ->
        target = $(event.target)
        ComponentsUtils.selectFromAutoSuggestion(target, @filterAsInput, 'data-client-id', @clients, @suggestionsContainer)
        @_applyFilter()
        return

    triggerFilterReset: (event) ->
        @_resetFilter()
        return

     _applyFilter: () ->
        status = @filterStatus.val()
        # @workerASInput.val('') 
        clients = []
        if status == 'all'
            clients = @clients
        else if status == 'paid'
            for client in @clients
                if not client.unpaid
                    clients.push(client)
        else if status == 'unpaid'
            for client in @clients
                if client.unpaid
                    clients.push(client)

        id = Number(@filterAsInput.attr('data-client-id'))
        if (! isNaN(id)) 
            filteredClients = []
            for client in clients
                if client.id == id 
                    filteredClients.push(client)
            clients = filteredClients

        if clients.length is 0
            @clientsContainer.html(@autoSuggestion.emptyState())
        else 
            @_renderClientsHTML(clients)

    _resetFilter: () ->
        @filterAsInput.val('')
        @filterAsInput.removeAttr('data-client-id')
        @filterStatus.val(@filterStatus[0].options[0].value)
        @_renderClientsHTML(@clients)