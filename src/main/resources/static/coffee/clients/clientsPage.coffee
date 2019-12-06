class @ClientsPage #extends @AbstractPage

    constructor: () ->
        @container = $('.js--page--container')

        @clickEvent = @_clickEventHandler.bind(this)
        @container.on 'click', @clickEvent
        ClientService.getAll(null, this, @_renderClients, @_renderClientsError)

        @createdNewClient = @_createdNewClient.bind(this)
        EventUtils.bindCreatedNewClient(@createdNewClient)
        @createClientDialog = new CreateClientDialog()
        @showClientDialog  = new ShowClientDialog()


        @clients = []
    
    destroy: () ->
        @container.off 'click', @clickEvent
        @clickEvent = null

        EventUtils.unbindCreatedNewClient(@createdNewClient)
        @createdNewClient = null

        @createClientDialog.destroy()
        @createClientDialog = null

        @showClientDialog.destroy()
        @showClientDialog = null

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
        @container.html(html)


    _renderClientsHTML: (clients) ->
        tableHtml = "
        <nav class='nav justify-content-end pt-3'>
                        <span class='nav-link span-a js--create--client'>Dodaj klijenta</span>
                    </nav>
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
                            <span class='client-details-icon js--show--client' data-client-id=#{client.id}></span>
                        </td>
				        <td class='table-text w-15'>#{firstName}</td>
				        <td class='table-text w-20'>#{lastName}</td>
                        <td class='table-text w-15'>#{phoneNumber}</td>
                        <td class='table-text w-20'>#{street}</td>
                        <td class='table-text w-20'>#{email}</td>
			        </tr>"
            
            tableHtml += rowHtml
        tableHtml += "</table></div>"

        @container.html(tableHtml)

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
